import 'package:flutter_test/flutter_test.dart';
import 'package:gif4work/api/api_response.dart';
import 'package:gif4work/data/data_source.dart';
import 'package:http/http.dart' as http;
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
    test('DataSource normal', () async {
      final client = MockClient();
      when(client.get(any))
          .thenAnswer((_) async => http.Response(jsonMock, 200));
      DataSource dataSource = NetworkDataSource(client);
      List<Data> data = await dataSource.loadData("test");
      expect(data[0].images.previewGif.url, 'https://test.gif');
    });

    test('DataSource fail', () async {
      final client = MockClient();
      when(client.get(any))
          .thenAnswer((_) async => http.Response('{message: "fail"}', 404));
      DataSource dataSource = NetworkDataSource(client);
      List<Data> data = await dataSource.loadData("test");
      expect(data.isEmpty, true);
    });
  });
}
