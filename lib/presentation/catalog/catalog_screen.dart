import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rshb_catalog/domain/bloc/catalog_bloc.dart';
import 'package:rshb_catalog/domain/model/farmer.dart';
import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/internal/dependencies/catalog_module.dart';

import 'widgets/section_tab.dart';
import 'widgets/section_tab_bar.dart';
import 'widgets/products_grid.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  static const _TABS = ['Продукты', 'Фермеры', 'Агротуры'];
  final _catalogBloc = CatalogModule.catalogBloc();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _catalogBloc.add(CatalogInitEvent());
    _tabController = TabController(vsync: this, length: _TABS.length);
  }

  @override
  void dispose() {
    _catalogBloc.close();
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        children: [
          _getTabBar(),
        ],
      ),
    );
  }

  Widget _getTabBar() {
    return SectionTabBar(
      controller: _tabController,
      tabs: _TABS.map((tab) => SectionTab(tab)).toList(growable: false),
    );
  }

  Widget _getTabBarView() {
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: _catalogBloc,
      builder: (context, state) {
        if (_tabController == null) return Container();

        List<Product> products = [];
        List<Farmer> farmers = [];
        if (state is CatalogReadyState) {
          products = state.products;
          farmers = state.farmers;
        }

        return TabBarView(
          controller: _tabController,
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  sliver: ProductsGrid(
                    products: products,
                    farmers: farmers,
                    onFavoriteTap: _changeFavorite,
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                child: Text('Фермеры'),
              ),
            ),
            Center(
              child: Container(
                child: Text('Агротуры'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _changeFavorite(int id) {
    _catalogBloc.add(CatalogChangeFavoriteEvent(id));
  }
}
