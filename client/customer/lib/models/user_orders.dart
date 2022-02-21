import 'dart:convert';

class UserOrders {
  final String? orderNo;
  final String? biddingStartTime;
  final String? biddingEndTime;
  final String? biddingRemainingTime;
  final int? maxBudget;
  final int? lowestbid;
  UserOrders({
    this.orderNo,
    this.biddingStartTime,
    this.biddingEndTime,
    this.biddingRemainingTime,
    this.maxBudget,
    this.lowestbid = -1,
  });

  UserOrders copyWith({
    String? orderNo,
    String? biddingStartTime,
    String? biddingEndTime,
    String? biddingRemainingTime,
    int? maxBudget,
    int? lowestbid,
  }) {
    return UserOrders(
      orderNo: orderNo ?? this.orderNo,
      biddingStartTime: biddingStartTime ?? this.biddingStartTime,
      biddingEndTime: biddingEndTime ?? this.biddingEndTime,
      biddingRemainingTime: biddingRemainingTime ?? this.biddingRemainingTime,
      maxBudget: maxBudget ?? this.maxBudget,
      lowestbid: lowestbid ?? this.lowestbid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'biddingStartTime': biddingStartTime,
      'biddingEndTime': biddingEndTime,
      'biddingRemainingTime': biddingRemainingTime,
      'maxBudget': maxBudget,
      'lowestbid': lowestbid,
    };
  }

  factory UserOrders.fromMap(dynamic map) {
    return UserOrders(
      orderNo: map['orderNo'],
      biddingStartTime: map['biddingStartTime'],
      biddingEndTime: map['biddingEndTime'],
      biddingRemainingTime: map['biddingRemainingTime'],
      maxBudget: map['maxBudget']?.toInt(),
      lowestbid: map['lowestbid']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserOrders.fromJson(String source) =>
      UserOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserOrders(orderNo: $orderNo, biddingStartTime: $biddingStartTime, biddingEndTime: $biddingEndTime, biddingRemainingTime: $biddingRemainingTime, maxBudget: $maxBudget, lowestbid: $lowestbid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserOrders &&
        other.orderNo == orderNo &&
        other.biddingStartTime == biddingStartTime &&
        other.biddingEndTime == biddingEndTime &&
        other.biddingRemainingTime == biddingRemainingTime &&
        other.maxBudget == maxBudget &&
        other.lowestbid == lowestbid;
  }

  @override
  int get hashCode {
    return orderNo.hashCode ^
        biddingStartTime.hashCode ^
        biddingEndTime.hashCode ^
        biddingRemainingTime.hashCode ^
        maxBudget.hashCode ^
        lowestbid.hashCode;
  }
}
