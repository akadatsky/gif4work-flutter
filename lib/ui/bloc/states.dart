import 'package:gif4work/api/api_response.dart';

abstract class ListState {}

class ListInitState implements ListState {}

class ListLoadedState implements ListState {
  final List<Data> data;

  ListLoadedState(this.data);
}
