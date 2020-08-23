import 'package:rshb_catalog/data/api/api_util.dart';
import 'package:rshb_catalog/data/api/fake_server.dart';

class ApiModule {
  static ApiUtil _apiUtil;

  static FakeServer _server() {
    return FakeServer();
  }

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(
        _server(),
      );
    }
    return _apiUtil;
  }
}
