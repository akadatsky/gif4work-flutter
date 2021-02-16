import 'package:gif4work/data/data_source.dart';
import 'package:injector/injector.dart';
import 'package:http/http.dart' as http;

class Di {
  static void setup() {
    final injector = Injector.appInstance;
    injector.registerSingleton<http.Client>(() => http.Client());
    injector.registerSingleton<DataSource>(() => NetworkDataSource());
  }
}
