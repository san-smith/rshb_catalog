import 'package:flutter/material.dart';
import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/presentation/design/favorite_button.dart';
import 'package:rshb_catalog/presentation/design/rating.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const ProductCard({
    Key key,
    @required this.product,
    this.onTap,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFFE0E0E0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Expanded(
                  child: _getHeader(),
                  flex: 4,
                ),
                Expanded(
                  child: _getBody(),
                  flex: 6,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _getHeader() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          product.image,
          fit: BoxFit.contain,
        ),
        Positioned(
          right: 11,
          top: 11,
          child: _getFavoriteButton(),
        ),
      ],
    );
  }

  Widget _getFavoriteButton() {
    return FavoriteButton(
      active: product.favorite,
      onTap: onFavoriteTap,
    );
  }

  Widget _getBody() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getTitle(),
          Spacer(),
          _getRating(),
          SizedBox(height: 8),
          _getShortDescription(),
          SizedBox(height: 8),
          _getFarmerName(),
          Spacer(),
          _getPrice(),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: product.title,
        style: TextStyle(
          color: Color(0xFF1C1C1C),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: ' / ${product.unit}',
            style: TextStyle(
              color: Color(0xFF969696),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getShortDescription() {
    return Text(
      '${product.shortDescription}\n',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 10,
        color: Color(0xFF969696),
      ),
    );
  }

  Widget _getFarmerName() {
    return Text(
      product.farmer?.title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 10,
        color: Color(0xFF1C1C1C),
      ),
    );
  }

  Widget _getPrice() {
    return Text(
      '${product.price.toStringAsFixed(0)} ₽',
      style: TextStyle(
        color: Color(0xFF1C1C1C),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _getRating() {
    return Rating(
      ratingCount: product.ratingCount,
      totalRating: product.totalRating,
    );
  }
}
