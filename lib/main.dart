
import 'package:flutter/material.dart';
import 'package:gif4work/di/Di.dart';
import 'package:gif4work/ui/bloc/bloc_list.dart';
import 'package:gif4work/ui/pages/list_screen.dart';

void main() {
  Di.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Next screen'),
                onPressed: _openNextScreen,
              )),
        ),
      ),
    );
  }

  void _openNextScreen() async {

    final bloc = ListBloc();
    final data = ListScreenData();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ListScreen(bloc, data)),
    );
  }
}
