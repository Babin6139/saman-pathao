import 'dart:convert';

class Time {
  String start;
  String end;
  Time({
    required this.start,
    required this.end,
  });

  Time copyWith({
    String? start,
    String? end,
  }) {
    return Time(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }

  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      start: map['start'] ?? '',
      end: map['end'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Time.fromJson(String source) => Time.fromMap(json.decode(source));

  @override
  String toString() => 'Time(start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Time && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
