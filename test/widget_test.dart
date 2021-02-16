import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gif4work/ui/bloc/bloc_list.dart';
import 'package:gif4work/ui/pages/list_screen.dart';
import 'package:gif4work/main.dart';

void main() {
  testWidgets('List widget test', (WidgetTester tester) async {
    final bloc = ListBloc();
    final data = ListScreenData();
    await tester.pumpWidget(buildTestableWidget(ListScreen(bloc, data)));

    await tester.enterText(find.byType(TextFormField), 'cat');

    expect(find.text('cat'), findsOneWidget);
    expect(find.text('dog'), findsNothing);
  });
}
