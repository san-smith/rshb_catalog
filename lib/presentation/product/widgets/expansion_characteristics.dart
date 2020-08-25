import 'package:flutter/material.dart';
import 'package:rshb_catalog/domain/model/product_characteristic.dart';

import 'characteristic_row.dart';

class ExpansionCharacteristics extends StatefulWidget {
  final List<ProductCharacteristic> characteristics;

  const ExpansionCharacteristics({Key key, this.characteristics})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpansionCharacteristicsState();
}

class _ExpansionCharacteristicsState extends State<ExpansionCharacteristics> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onExpandChanged,
      child: Column(
        children: [
          if (_expanded) _getBody(),
          SizedBox(height: 8),
          _getHeader(),
        ],
      ),
    );
  }

  Widget _getHeader() {
    final title = _expanded ? 'Скрыть характеристики' : 'Все характеристики';
    final icon = _expanded ? Icons.keyboard_arrow_up : Icons.chevron_right;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF42AB44),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Icon(
          icon,
          color: Color(0xFF42AB44),
        ),
      ],
    );
  }

  Widget _getBody() {
    return Column(
      children: widget.characteristics
          .map((it) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CharacteristicRow(it),
              ))
          .toList(),
    );
  }

  void _onExpandChanged() {
    setState(() {
      _expanded = !_expanded;
    });
  }
}
