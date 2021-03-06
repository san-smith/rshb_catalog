import 'package:flutter/material.dart';

import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/presentation/catalog/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final Function(int) onFavoriteTap;
  final Function(Product) onTap;

  const ProductsGrid({
    Key key,
    @required this.products,
    this.onFavoriteTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 0.55,
      children: products
          .map((product) => ProductCard(
                product: product,
                onFavoriteTap: () => onFavoriteTap(product.id),
                onTap: () => onTap(product),
              ))
          .toList(),
    );
  }
}
