import 'dart:convert';

class TimeFrame {
  String start;
  String end;
  TimeFrame({
    required this.start,
    required this.end,
  });

  TimeFrame copyWith({
    String? start,
    String? end,
  }) {
    return TimeFrame(
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

  factory TimeFrame.fromMap(Map<String, dynamic> map) {
    return TimeFrame(
      start: map['start'] ?? '',
      end: map['end'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeFrame.fromJson(String source) =>
      TimeFrame.fromMap(json.decode(source));

  @override
  String toString() => 'TimeFrame(start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeFrame && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
