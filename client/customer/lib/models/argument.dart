import 'dart:convert';

import 'package:flutter/material.dart';

class Arguments {
  final String orderNo;
  final String userName;
  Arguments({
    required this.orderNo,
    required this.userName,
  });

  Arguments copyWith({
    String? orderNo,
    String? userName,
  }) {
    return Arguments(
      orderNo: orderNo ?? this.orderNo,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'userName': userName,
    };
  }

  factory Arguments.fromMap(Map<String, dynamic> map) {
    return Arguments(
      orderNo: map['orderNo'] ?? '',
      userName: map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Arguments.fromJson(String source) =>
      Arguments.fromMap(json.decode(source));

  @override
  String toString() => 'Arguments(orderNo: $orderNo, userName: $userName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Arguments &&
        other.orderNo == orderNo &&
        other.userName == userName;
  }

  @override
  int get hashCode => orderNo.hashCode ^ userName.hashCode;
}
