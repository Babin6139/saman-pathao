import 'dart:convert';

import 'package:collection/collection.dart';

class Bids {
  List<int> bidAmount;
  Bids({
    required this.bidAmount,
  });

  Bids copyWith({
    List<int>? bidAmount,
  }) {
    return Bids(
      bidAmount: bidAmount ?? this.bidAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bidAmount': bidAmount,
    };
  }

  factory Bids.fromMap(Map<String, dynamic> map) {
    return Bids(
      bidAmount: List<int>.from(map['bidAmount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bids.fromJson(String source) => Bids.fromMap(json.decode(source));

  @override
  String toString() => 'Bids(bidAmount: $bidAmount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Bids && listEquals(other.bidAmount, bidAmount);
  }

  @override
  int get hashCode => bidAmount.hashCode;
}
