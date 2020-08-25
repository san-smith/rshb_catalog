import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final String iconUri;
  final bool active;
  final VoidCallback onTap;

  const RoundedButton({
    Key key,
    @required this.title,
    this.iconUri,
    @required this.active,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 79,
      child: GestureDetector(
        child: Column(
          children: [
            _getIcon(),
            SizedBox(height: 8),
            _getTitle(),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF969696),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getIcon() {
    final color = active ? Colors.white : Color(0xFF1C1C1C);
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: active ? Color(0xFF42AB44) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFFE0E0E0),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: iconUri != null
            ? SvgPicture.asset(
                iconUri,
                color: color,
              )
            : Text(
                title[0],
                style: TextStyle(
                  color: color,
                ),
              ),
      ),
    );
  }
}
