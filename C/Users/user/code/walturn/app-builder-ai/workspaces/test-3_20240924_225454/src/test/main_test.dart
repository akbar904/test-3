
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counter_app/main.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('renders MyApp', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(MyApp), findsOneWidget);
		});
	});

	group('MyApp Widget', () {
		testWidgets('displays MaterialApp', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(MaterialApp), findsOneWidget);
		});

		testWidgets('MaterialApp has HomeScreen as home', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
			expect(materialApp.home, isA<HomeScreen>());
		});
	});

	group('CounterCubit', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = MockCounterCubit();
		});

		blocTest<CounterCubit, int>(
			'emits [100] when increment is called',
			build: () => counterCubit,
			act: (cubit) => cubit.increment(),
			expect: () => [100],
		);
	});
}
