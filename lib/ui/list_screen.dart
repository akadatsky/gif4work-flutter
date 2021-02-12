import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gif4work/api/ApiResponse.dart';
import 'package:gif4work/const.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Data> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gifs list"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Search text"),
              style: TextStyle(fontSize: 20.0, color: Colors.black),
              textInputAction: TextInputAction.search,
              onFieldSubmitted: onSearchPressed,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Column(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: images[index]?.images?.previewGif?.url,
                        placeholder: (BuildContext context, String url) =>
                            Placeholder(
                          fallbackWidth: 320,
                          fallbackHeight: 240,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: images.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearchPressed(String request) {
    Fluttertoast.showToast(msg: 'request: $request');
    _getData(request).then((response) {
      if (response.statusCode == 200) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(jsonDecode(response.body));
        print('data length: ${apiResponse.data.length}');
        setState(() {
          images = apiResponse.data;
        });
      } else {
        print(response.statusCode);
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<http.Response> _getData(String request) async {
    var queryParameters = {
      'api_key': giphyApiKey,
      'q': request,
    };
    var uri = Uri.https(giphyAuthority, giphyPath, queryParameters);
    return await http.get(uri);
  }
}
