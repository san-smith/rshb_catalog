import 'package:flutter/material.dart';
import 'package:rshb_catalog/domain/model/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({
    Key key,
    @required this.product,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(widget.product.title),
    );
  }
}
