abstract class ListEvent {}

class UpdateListEvent extends ListEvent {
  final String request;

  UpdateListEvent(this.request);
}
