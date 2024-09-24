
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counter_app/cubits/counter_cubit.dart';

class MockCounterCubit extends MockCubit<Counter> implements CounterCubit {}

void main() {
	group('CounterCubit', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = CounterCubit();
		});

		tearDown(() {
			counterCubit.close();
		});

		test('initial state is Counter with value 0', () {
			expect(counterCubit.state, Counter(value: 0));
		});

		blocTest<CounterCubit, Counter>(
			'emits [Counter(value: 100)] when increment is called',
			build: () => counterCubit,
			act: (cubit) => cubit.increment(),
			expect: () => [Counter(value: 100)],
		);

		blocTest<CounterCubit, Counter>(
			'emits [Counter(value: 100), Counter(value: 200)] when increment is called twice',
			build: () => counterCubit,
			act: (cubit) {
				cubit.increment();
				cubit.increment();
			},
			expect: () => [Counter(value: 100), Counter(value: 200)],
		);
	});
}
