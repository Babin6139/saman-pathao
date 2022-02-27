import 'dart:convert';

import 'package:collection/collection.dart';

class Dimension {
  List<double> length;
  List<double> width;
  List<double> height;
  Dimension({
    required this.length,
    required this.width,
    required this.height,
  });

  Dimension copyWith({
    List<double>? length,
    List<double>? width,
    List<double>? height,
  }) {
    return Dimension(
      length: length ?? this.length,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'length': length,
      'width': width,
      'height': height,
    };
  }

  factory Dimension.fromMap(Map<String, dynamic> map) {
    return Dimension(
      length: List<double>.from(map['length']),
      width: List<double>.from(map['width']),
      height: List<double>.from(map['height']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dimension.fromJson(String source) =>
      Dimension.fromMap(json.decode(source));

  @override
  String toString() =>
      'Dimension(length: $length, width: $width, height: $height)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Dimension &&
        listEquals(other.length, length) &&
        listEquals(other.width, width) &&
        listEquals(other.height, height);
  }

  @override
  int get hashCode => length.hashCode ^ width.hashCode ^ height.hashCode;
}
