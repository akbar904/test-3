
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counter_app/widgets/counter_display.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
	group('CounterDisplay Widget', () {
		testWidgets('displays the current counter value', (WidgetTester tester) async {
			final mockCounterCubit = MockCounterCubit();
			when(() => mockCounterCubit.state).thenReturn(100);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<CounterCubit>(
						create: (_) => mockCounterCubit,
						child: CounterDisplay(),
					),
				),
			);

			expect(find.text('100'), findsOneWidget);
		});

		testWidgets('updates the counter display when cubit state changes', (WidgetTester tester) async {
			final mockCounterCubit = MockCounterCubit();
			whenListen(
				mockCounterCubit,
				Stream.fromIterable([0, 100, 200]),
				initialState: 0,
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<CounterCubit>(
						create: (_) => mockCounterCubit,
						child: CounterDisplay(),
					),
				),
			);

			expect(find.text('0'), findsOneWidget);
			await tester.pump();
			expect(find.text('100'), findsOneWidget);
			await tester.pump();
			expect(find.text('200'), findsOneWidget);
		});
	});
}
