import 'dart:convert';

import 'package:gif4work/api/api_response.dart';
import 'package:gif4work/const.dart';
import 'package:http/http.dart' as http;
import 'package:injector/injector.dart';

abstract class DataSource {
  Future<List<Data>> loadData(String request);
}

class NetworkDataSource implements DataSource {

  Future<List<Data>> loadData(String request) async {
    var queryParameters = {
      'api_key': giphyApiKey,
      'q': request,
    };
    var uri = Uri.https(giphyAuthority, giphyPath, queryParameters);
    http.Client client = Injector.appInstance.get<http.Client>();
    http.Response response = await client.get(uri);

    if (response.statusCode == 200) {
      ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
      return apiResponse.data;
    } else {
      return [];
    }
  }
}
