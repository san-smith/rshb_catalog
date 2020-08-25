import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFFE0E0E0),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/icons/left_arrow.svg'),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
