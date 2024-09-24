
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/counter_model.dart';

class CounterCubit extends Cubit<Counter> {
	CounterCubit() : super(Counter(value: 0));

	void increment() {
		emit(Counter(value: state.value * 100));
	}
}
