import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rshb_catalog/domain/bloc/catalog_bloc.dart';
import 'package:rshb_catalog/domain/bloc/category_bloc.dart';
import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/internal/dependencies/catalog_module.dart';
import 'package:rshb_catalog/presentation/product/product_screen.dart';

import 'widgets/section_tab.dart';
import 'widgets/section_tab_bar.dart';
import 'widgets/products_grid.dart';
import 'widgets/category_item.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  static const _TABS = ['Продукты', 'Фермеры', 'Агротуры'];
  final _catalogBloc = CatalogModule.catalogBloc();
  final _categoryBloc = CatalogModule.categoryBloc();
  TabController _tabController;
  List<Product> _products = [];
  List<Category> _categories = [];
  bool _sortByPrice = false;

  @override
  void initState() {
    super.initState();
    _catalogBloc.add(CatalogInitEvent());
    _categoryBloc.add(CategoryInitEvent());
    _tabController = TabController(vsync: this, length: _TABS.length);
    _tabController.addListener(_onTabChangeListener);
  }

  @override
  void dispose() {
    _catalogBloc.close();
    _categoryBloc.close();
    _tabController.removeListener(_onTabChangeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text(
        'Каталог',
        style: TextStyle(
          color: Color(0xFF1C1C1C),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _getBody() {
    return NestedScrollView(
      headerSliverBuilder: (context, scrolled) => [
        SliverToBoxAdapter(
          child: _getHeader(),
        ),
      ],
      body: _getTabBarView(),
    );
  }

  Widget _getHeader() {
    return Column(
      children: [
        SizedBox(height: 30),
        _getTabBar(),
        SizedBox(height: 30),
        _getCategories(),
      ],
    );
  }

  Widget _getTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SectionTabBar(
        controller: _tabController,
        tabs: _TABS.map((tab) => SectionTab(tab)).toList(growable: false),
      ),
    );
  }

  Widget _getCategories() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      bloc: _categoryBloc,
      builder: (context, state) {
        if (state is CategoryReadyState) {
          _categories = state.categories;
        }
        return SizedBox(
          height: 76,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _getSortButton();
              }
              return CategoryItem(
                title: _categories[index - 1].title,
                iconUri: _categories[index - 1].iconUri,
                active: false,
                onTap: () {},
              );
            },
          ),
        );
      },
    );
  }

  Widget _getSortButton() {
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: _catalogBloc,
      builder: (context, state) {
        if (state is CatalogReadyState) {
          _sortByPrice = state.sortByPrice;
        }

        return CategoryItem(
          title: 'Сортировать',
          active: _sortByPrice,
          onTap: _sortProducts,
        );
      },
    );
  }

  Widget _getTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _getProducts(),
        _getFarmers(),
        _getTours(),
      ],
    );
  }

  Widget _getProducts() {
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: _catalogBloc,
      builder: (context, state) {
        if (state is CatalogLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CatalogReadyState) {
          _products = state.products;
        }

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              sliver: ProductsGrid(
                products: _products,
                onFavoriteTap: _changeFavorite,
                onTap: _goToProductScreen,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getFarmers() {
    return Center(
      child: Container(
        child: Text('Фермеры'),
      ),
    );
  }

  Widget _getTours() {
    return Center(
      child: Container(
        child: Text('Агротуры'),
      ),
    );
  }

  void _changeFavorite(int id) {
    _catalogBloc.add(CatalogChangeFavoriteEvent(id));
  }

  void _goToProductScreen(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product: product)),
    );
  }

  void _onTabChangeListener() {
    if (_tabController.indexIsChanging) {
      _categoryBloc.add(CategoryChangeSectionEvent(_tabController.index + 1));
    }
  }

  void _sortProducts() {
    _catalogBloc.add(CatalogSortEvent());
  }
}
