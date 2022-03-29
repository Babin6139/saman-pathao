import 'dart:convert';

import 'package:collection/collection.dart';

class ShipmentDimension {
  List<double> length;
  List<double> width;
  List<double> height;
  ShipmentDimension({
    required this.length,
    required this.width,
    required this.height,
  });

  ShipmentDimension copyWith({
    List<double>? length,
    List<double>? width,
    List<double>? height,
  }) {
    return ShipmentDimension(
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

  factory ShipmentDimension.fromMap(Map<String, dynamic> map) {
    return ShipmentDimension(
      length: List<double>.from(map['length']),
      width: List<double>.from(map['width']),
      height: List<double>.from(map['height']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipmentDimension.fromJson(String source) =>
      ShipmentDimension.fromMap(json.decode(source));

  @override
  String toString() =>
      'ShipmentDimension(length: $length, width: $width, height: $height)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ShipmentDimension &&
        listEquals(other.length, length) &&
        listEquals(other.width, width) &&
        listEquals(other.height, height);
  }

  @override
  int get hashCode => length.hashCode ^ width.hashCode ^ height.hashCode;
}
