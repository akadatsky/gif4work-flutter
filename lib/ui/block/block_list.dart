import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif4work/api/ApiResponse.dart';
import 'package:gif4work/const.dart';
import 'package:gif4work/ui/block/states.dart';
import 'package:http/http.dart' as http;

import 'events.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitState());

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is UpdateListEvent) {
      var queryParameters = {
        'api_key': giphyApiKey,
        'q': event.request,
      };
      var uri = Uri.https(giphyAuthority, giphyPath, queryParameters);
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(jsonDecode(response.body));
        print('data length: ${apiResponse.data.length}');
        yield ListLoadedState(apiResponse.data);
      } else {
        print(response.statusCode);
      }
    }
  }
}
