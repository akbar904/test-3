
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_app/cubits/counter_cubit.dart';

class CounterDisplay extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final counterValue = context.watch<CounterCubit>().state;
		return Center(
			child: Text(
				'$counterValue',
				style: TextStyle(fontSize: 24),
			),
		);
	}
}
