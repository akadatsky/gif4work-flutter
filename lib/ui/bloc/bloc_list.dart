import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif4work/api/ApiResponse.dart';
import 'package:gif4work/data/data_source.dart';
import 'package:gif4work/ui/bloc/states.dart';
import 'package:injector/injector.dart';

import 'events.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitState());

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is UpdateListEvent) {
      DataSource dataSource = Injector.appInstance.get<DataSource>();
      List<Data> result = await dataSource.loadData(event.request);
      yield ListLoadedState(result);
    }
  }
}
