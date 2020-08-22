import 'package:rshb_catalog/data/api/api_util.dart';

class ApiModule {
  static ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil();
    }
    return _apiUtil;
  }
}