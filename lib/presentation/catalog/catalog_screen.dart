import 'package:flutter/material.dart';

import 'package:rshb_catalog/domain/bloc/catalog_bloc.dart';
import 'package:rshb_catalog/internal/dependencies/catalog_module.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _catalogBloc = CatalogModule.catalogBloc();

  @override
  void initState() {
    super.initState();
    _catalogBloc.add(CatalogInitEvent());
  }

  @override
  void dispose() {
    _catalogBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Center(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text(
        'Каталог',
        style: TextStyle(
          color: Color(0xFF1C1C1C),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: false,
    );
  }
}
