import 'package:flutter/material.dart';

class SectionTab extends StatelessWidget {
  final String title;

  const SectionTab(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(title),
        ),
      ),
    );
  }
}
