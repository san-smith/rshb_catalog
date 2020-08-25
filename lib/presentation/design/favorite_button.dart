import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteButton extends StatelessWidget {
  final double size;
  final bool active;
  final VoidCallback onTap;

  const FavoriteButton({
    Key key,
    this.size = 32,
    this.active = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: Color(0xFFBDBDBD),
          ),
        ),
        child: active
            ? SvgPicture.asset('assets/icons/favorite_filled.svg')
            : SvgPicture.asset('assets/icons/favorite.svg'),
      ),
      onTap: onTap,
    );
  }
}
