import 'package:flutter_test/flutter_test.dart';
import 'package:gif4work/api/api_response.dart';
import 'package:gif4work/data/data_source.dart';
import 'package:http/http.dart' as http;
import 'package:injector/injector.dart';
import 'package:mockito/mockito.dart';

var jsonMock = '''
{
  "data": [
    {
      "images": {
        "preview_gif": {
          "url": "https://test.gif"
        }
      }
    }
  ]
}
''';

class MockClient extends Mock implements http.Client {}

void main() {
  group('Data', () {
    final client = MockClient();
    final injector = Injector.appInstance;

    setUpAll(() async {
      injector.registerSingleton<http.Client>(() => client);
      injector.registerSingleton<DataSource>(() => NetworkDataSource());
    });

    tearDownAll(() async {
      injector.clearAll();
    });

    test('DataSource normal', () async {
      when(client.get(any))
          .thenAnswer((_) async => http.Response(jsonMock, 200));
      DataSource dataSource = injector.get<DataSource>();
      List<Data> data = await dataSource.loadData("test");
      expect(data[0].images.previewGif.url, 'https://test.gif');
    });

    test('DataSource fail', () async {
      when(client.get(any))
          .thenAnswer((_) async => http.Response('{message: "fail"}', 404));
      DataSource dataSource = injector.get<DataSource>();
      List<Data> data = await dataSource.loadData("test");
      expect(data.isEmpty, true);
    });
  });
}
