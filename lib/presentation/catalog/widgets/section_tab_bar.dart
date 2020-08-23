import 'package:flutter/material.dart';

class SectionTabBar extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabs;

  const SectionTabBar({
    Key key,
    this.controller,
    this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: TabBar(
        controller: controller,
        unselectedLabelColor: Color(0xFF1C1C1C),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color(0xFF42AB44),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Color(0xFF42AB44),
            ),
          ],
        ),
        tabs: tabs,
      ),
    );
  }
}
