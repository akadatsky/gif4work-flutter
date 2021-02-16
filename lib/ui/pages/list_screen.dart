import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif4work/api/api_response.dart';
import 'package:gif4work/ui/bloc/bloc_list.dart';
import 'package:gif4work/ui/bloc/events.dart';
import 'package:gif4work/ui/bloc/states.dart';

class ListScreen extends StatefulWidget {
  final ListBloc bloc;
  final ListScreenData screenData;

  const ListScreen(this.bloc, this.screenData, {Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      cubit: widget.bloc,
      listener: (context, state) {
        if (state is ListLoadedState) {
          setState(() {
            widget.screenData.images = state.data;
          });
        }
      },
      child: _buildUi(),
    );
  }

  Widget _buildUi() {
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
                        imageUrl: widget
                            .screenData.images[index]?.images?.previewGif?.url,
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
                itemCount: widget.screenData.images.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearchPressed(String request) {
    widget.bloc.add(UpdateListEvent(request));
  }
}

class ListScreenData {
  List<Data> images = [];
}
