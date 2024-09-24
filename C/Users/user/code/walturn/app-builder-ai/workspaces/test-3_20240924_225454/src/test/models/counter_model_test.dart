
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/models/counter_model.dart';

void main() {
	group('Counter Model Tests', () {
		test('Counter model should be initialized with a value', () {
			final counter = Counter(value: 0);
			expect(counter.value, 0);
		});

		test('Counter model should serialize to JSON correctly', () {
			final counter = Counter(value: 100);
			final json = counter.toJson();
			expect(json['value'], 100);
		});

		test('Counter model should deserialize from JSON correctly', () {
			final json = {'value': 200};
			final counter = Counter.fromJson(json);
			expect(counter.value, 200);
		});
	});
}
