import 'package:gif4work/data/data_source.dart';
import 'package:injector/injector.dart';

class Di {
  static void setup() {
    final injector = Injector.appInstance;
    injector.registerSingleton<DataSource>(() => NetworkDataSource());
  }
}
