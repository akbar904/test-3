
class Counter {
	final int value;

	Counter({required this.value});

	factory Counter.fromJson(Map<String, dynamic> json) {
		return Counter(value: json['value']);
	}

	Map<String, dynamic> toJson() {
		return {'value': value};
	}
}
