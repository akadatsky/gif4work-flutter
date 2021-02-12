import 'package:gif4work/api/ApiResponse.dart';

abstract class ListState {}

class ListInitState implements ListState {}

class ListLoadedState implements ListState {
  final List<Data> data;

  ListLoadedState(this.data);
}
