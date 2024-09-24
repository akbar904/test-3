
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_app/cubits/counter_cubit.dart';
import 'package:counter_app/screens/home_screen.dart';

class MockCounterCubit extends MockCubit<Counter> implements CounterCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = MockCounterCubit();
		});

		tearDown(() {
			counterCubit.close();
		});

		testWidgets('displays initial counter text', (WidgetTester tester) async {
			when(() => counterCubit.state).thenReturn(Counter(0));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Current Counter: 0'), findsOneWidget);
		});

		testWidgets('displays incremented counter text when increment button is pressed', (WidgetTester tester) async {
			whenListen(
				counterCubit,
				Stream.fromIterable([Counter(0), Counter(100)]),
				initialState: Counter(0),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.pump();
			expect(find.text('Current Counter: 0'), findsOneWidget);

			await tester.tap(find.byType(FloatingActionButton));
			await tester.pumpAndSettle();

			expect(find.text('Current Counter: 100'), findsOneWidget);
		});
	});
}
