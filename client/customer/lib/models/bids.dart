import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:customer/models/bid_amount.dart';
import 'package:customer/models/transporter_model.dart';

class Bids {
  final List<Transporter> transporter;
  final List<int> bidAmount;
  Bids({
    required this.transporter,
    required this.bidAmount,
  });

  Bids copyWith({
    List<Transporter>? transporter,
    List<int>? bidAmount,
  }) {
    return Bids(
      transporter: transporter ?? this.transporter,
      bidAmount: bidAmount ?? this.bidAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transporter': transporter.map((x) => x.toMap()).toList(),
      'bidAmount': bidAmount,
    };
  }

  factory Bids.fromMap(Map<String, dynamic> map) {
    return Bids(
      transporter: List<Transporter>.from(
          map['transporter']?.map((x) => Transporter.fromMap(x))),
      bidAmount: List<int>.from(map['bidAmount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bids.fromJson(String source) => Bids.fromMap(json.decode(source));

  @override
  String toString() => 'Bids(transporter: $transporter, bidAmount: $bidAmount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Bids &&
        listEquals(other.transporter, transporter) &&
        listEquals(other.bidAmount, bidAmount);
  }

  @override
  int get hashCode => transporter.hashCode ^ bidAmount.hashCode;
}
