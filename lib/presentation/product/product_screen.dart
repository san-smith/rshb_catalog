import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/domain/model/product_characteristic.dart';
import 'package:rshb_catalog/presentation/design/circle_back_button.dart';
import 'package:rshb_catalog/presentation/design/favorite_button.dart';
import 'package:rshb_catalog/presentation/design/rating.dart';
import 'package:rshb_catalog/presentation/product/widgets/characteristic_row.dart';
import 'package:rshb_catalog/presentation/product/widgets/expansion_characteristics.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  final VoidCallback onFavoriteTap;

  const ProductScreen({
    Key key,
    @required this.product,
    this.onFavoriteTap,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getHeader(),
          _getContent(),
        ],
      ),
    );
  }

  Widget _getHeader() {
    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_product.image),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(18, 28, 28, 28),
                    blurRadius: 2,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 60,
            child: CircleBackButton(),
          ),
          Positioned(
            right: 16,
            top: 60,
            child: FavoriteButton(
              size: 40.0,
              active: _product.favorite,
              onTap: _onFavoriteTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getTitle(),
          SizedBox(height: 12),
          _getRating(),
          SizedBox(height: 20),
          _getPrice(),
          SizedBox(height: 54),
          _getDescription(),
          SizedBox(height: 40),
          _getCharacteristics(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return RichText(
      text: TextSpan(
        text: _product.title,
        style: TextStyle(
          color: Color(0xFF1C1C1C),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: ' / ${_product.unit}',
            style: TextStyle(
              color: Color(0xFF969696),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPrice() {
    return Text(
      '${_product.price.toStringAsFixed(0)} ₽',
      style: TextStyle(
        color: Color(0xFF1C1C1C),
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _getRating() {
    return Rating(
      ratingCount: _product.ratingCount,
      totalRating: _product.totalRating,
    );
  }

  Widget _getDescription() {
    return Text(
      _product.description,
      style: TextStyle(
        height: 1.56,
      ),
    );
  }

  Widget _getCharacteristics() {
    final lastShowedIndex = math.min(_product.characteristics.length, 6);

    final showedCharacteristics =
        _product.characteristics.sublist(0, lastShowedIndex);

    final expandebleCharacteristics = _product.characteristics.sublist(
        lastShowedIndex,
        math.max(lastShowedIndex, _product.characteristics.length));

    return Column(
      children: [
        ...showedCharacteristics
            .map((it) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CharacteristicRow(it),
                ))
            .toList(),
        if (expandebleCharacteristics.isNotEmpty)
          _getExpansionCharacteristics(expandebleCharacteristics),
      ],
    );
  }

  Widget _getExpansionCharacteristics(
      List<ProductCharacteristic> characteristics) {
    return ExpansionCharacteristics(characteristics: characteristics);
  }

  void _onFavoriteTap() {
    widget.onFavoriteTap();
    setState(() {
      _product = _product.copyWith(favorite: !_product.favorite);
    });
  }
}
