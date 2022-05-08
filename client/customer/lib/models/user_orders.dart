import 'dart:convert';

import 'package:collection/collection.dart';

class UserOrders {
  final String orderNo;
  final String orderId;
  final String status;
  final String orderStartTime;
  final String orderEndTime;
  final int maxBudget;
  final int lowestbids;
  final int distance;
  final List<dynamic> shipments;
  final int shipmentWeight;
  final String photo;
  UserOrders({
    required this.orderNo,
    required this.orderId,
    required this.status,
    required this.orderStartTime,
    required this.orderEndTime,
    required this.maxBudget,
    required this.lowestbids,
    required this.distance,
    required this.shipments,
    required this.shipmentWeight,
    required this.photo,
  });

  UserOrders copyWith({
    String? orderNo,
    String? orderId,
    String? status,
    String? orderStartTime,
    String? orderEndTime,
    int? maxBudget,
    int? lowestbids,
    int? distance,
    List<dynamic>? shipments,
    int? shipmentWeight,
    String? photo,
  }) {
    return UserOrders(
      orderNo: orderNo ?? this.orderNo,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      orderStartTime: orderStartTime ?? this.orderStartTime,
      orderEndTime: orderEndTime ?? this.orderEndTime,
      maxBudget: maxBudget ?? this.maxBudget,
      lowestbids: lowestbids ?? this.lowestbids,
      distance: distance ?? this.distance,
      shipments: shipments ?? this.shipments,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'orderNo': orderNo});
    result.addAll({'orderId': orderId});
    result.addAll({'status': status});
    result.addAll({'orderStartTime': orderStartTime});
    result.addAll({'orderEndTime': orderEndTime});
    result.addAll({'maxBudget': maxBudget});
    result.addAll({'lowestbids': lowestbids});
    result.addAll({'distance': distance});
    result.addAll({'shipments': shipments});
    result.addAll({'shipmentWeight': shipmentWeight});
    result.addAll({'photo': photo});

    return result;
  }

  factory UserOrders.fromMap(Map<String, dynamic> map) {
    return UserOrders(
        orderNo: map['orderNo'] ?? '',
        orderId: map['_id'] ?? '',
        status: map['status'] ?? '',
        orderStartTime: map['orderStartTime'] ?? '',
        orderEndTime: map['orderEndTime'] ?? '',
        maxBudget: map['maxBudget']?.toInt() ?? 0,
        lowestbids: map['bidCost']?.toInt() ?? -1,
        distance: map['distance']?.toInt() ?? 0,
        shipments: List<dynamic>.from(map['shipments']),
        shipmentWeight: map['shipmentWeight']?.toInt() ?? 0,
        photo: map['shipmentPhoto'] ?? "https://picsum.photos/200/300");
  }

  String toJson() => json.encode(toMap());

  factory UserOrders.fromJson(String source) =>
      UserOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserOrders(orderNo: $orderNo, orderId: $orderId, status: $status, orderStartTime: $orderStartTime, orderEndTime: $orderEndTime, maxBudget: $maxBudget, lowestbids: $lowestbids, distance: $distance, shipments: $shipments, shipmentWeight: $shipmentWeight, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UserOrders &&
        other.orderNo == orderNo &&
        other.orderId == orderId &&
        other.status == status &&
        other.orderStartTime == orderStartTime &&
        other.orderEndTime == orderEndTime &&
        other.maxBudget == maxBudget &&
        other.lowestbids == lowestbids &&
        other.distance == distance &&
        listEquals(other.shipments, shipments) &&
        other.shipmentWeight == shipmentWeight &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return orderNo.hashCode ^
        orderId.hashCode ^
        status.hashCode ^
        orderStartTime.hashCode ^
        orderEndTime.hashCode ^
        maxBudget.hashCode ^
        lowestbids.hashCode ^
        distance.hashCode ^
        shipments.hashCode ^
        shipmentWeight.hashCode ^
        photo.hashCode;
  }
}
