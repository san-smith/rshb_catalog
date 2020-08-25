import 'package:flutter/material.dart';
import 'package:rshb_catalog/domain/model/product_characteristic.dart';
import 'package:rshb_catalog/presentation/design/dash_divider.dart';

class CharacteristicRow extends StatelessWidget {
  final ProductCharacteristic characteristic;

  const CharacteristicRow(
    this.characteristic, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          characteristic.title,
          style: TextStyle(
            color: Color(0xFF969696),
            fontSize: 12,
            height: 1.17,
          ),
        ),
        Expanded(child: DashDivider()),
        Text(
          characteristic.value,
          style: TextStyle(
            color: Color(0xFF1C1C1C),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.17,
          ),
        ),
      ],
    );
  }
}
