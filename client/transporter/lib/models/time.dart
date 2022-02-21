import 'dart:convert';

class Time {
  String startTime;
  String endTime;
  Time({
    required this.startTime,
    required this.endTime,
  });

  Time copyWith({
    String? startTime,
    String? endTime,
  }) {
    return Time(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Time.fromJson(String source) => Time.fromMap(json.decode(source));

  @override
  String toString() => 'Time(startTime: $startTime, endTime: $endTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Time &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}
