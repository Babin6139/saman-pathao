import 'dart:convert';

class BidAmount {
  final int amount;
  BidAmount({
    required this.amount,
  });

  BidAmount copyWith({
    int? amount,
  }) {
    return BidAmount(
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
    };
  }

  factory BidAmount.fromMap(Map<String, dynamic> map) {
    return BidAmount(
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BidAmount.fromJson(String source) =>
      BidAmount.fromMap(json.decode(source));

  @override
  String toString() => 'BidAmount(amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BidAmount && other.amount == amount;
  }

  @override
  int get hashCode => amount.hashCode;
}
