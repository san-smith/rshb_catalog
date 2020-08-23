import 'package:flutter/material.dart';

import 'package:rshb_catalog/domain/model/farmer.dart';
import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/presentation/catalog/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final List<Farmer> farmers;
  final Function(int productId) onFavoriteTap;

  const ProductsGrid({
    Key key,
    @required this.products,
    @required this.farmers,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 0.55,
      children: products
          .map((product) => ProductCard(
                product: product,
                farmerTitle: farmers
                        .firstWhere((it) => it.id == product.farmerId)
                        ?.title ??
                    '',
                onFavoriteTap: () => onFavoriteTap(product.id),
              ))
          .toList(),
    );
  }
}
