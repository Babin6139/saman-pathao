import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:transporter/models/time.dart';

class PickUpOrders {
  String orderNo;
  String shipmentPhoto;
  String orderStatus;
  double bidCost;
  Time timeFrame;
  List<String> startPoint;
  List<String> destination;
  bool fragile;
  double distance;
  List<String> shipments;
  double shipmentWeight;
  String userName;
  PickUpOrders({
    required this.orderNo,
    required this.shipmentPhoto,
    required this.orderStatus,
    required this.bidCost,
    required this.timeFrame,
    required this.startPoint,
    required this.destination,
    required this.fragile,
    required this.distance,
    required this.shipments,
    required this.shipmentWeight,
    required this.userName,
  });

  PickUpOrders copyWith({
    String? orderNo,
    String? shipmentPhoto,
    String? orderStatus,
    double? bidCost,
    Time? timeFrame,
    List<String>? startPoint,
    List<String>? destination,
    bool? fragile,
    double? distance,
    List<String>? shipments,
    double? shipmentWeight,
    String? userName,
  }) {
    return PickUpOrders(
      orderNo: orderNo ?? this.orderNo,
      shipmentPhoto: shipmentPhoto ?? this.shipmentPhoto,
      orderStatus: orderStatus ?? this.orderStatus,
      bidCost: bidCost ?? this.bidCost,
      timeFrame: timeFrame ?? this.timeFrame,
      startPoint: startPoint ?? this.startPoint,
      destination: destination ?? this.destination,
      fragile: fragile ?? this.fragile,
      distance: distance ?? this.distance,
      shipments: shipments ?? this.shipments,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'shipmentPhoto': shipmentPhoto,
      'orderStatus': orderStatus,
      'bidCost': bidCost,
      'timeFrame': timeFrame.toMap(),
      'startPoint': startPoint,
      'destination': destination,
      'fragile': fragile,
      'distance': distance,
      'shipments': shipments,
      'shipmentWeight': shipmentWeight,
      'userName': userName,
    };
  }

  factory PickUpOrders.fromMap(Map<String, dynamic> map) {
    return PickUpOrders(
      orderNo: map['orderNo'] ?? '',
      shipmentPhoto: map['shipmentPhoto'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      bidCost: map['bidCost']?.toDouble() ?? 0.0,
      timeFrame: Time.fromMap(map['timeFrame']),
      startPoint: List<String>.from(map['startPoint']),
      destination: List<String>.from(map['destination']),
      fragile: map['fragile'] ?? false,
      distance: map['distance']?.toDouble() ?? 0.0,
      shipments: List<String>.from(map['shipments']),
      shipmentWeight: map['shipmentWeight']?.toDouble() ?? 0.0,
      userName: map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PickUpOrders.fromJson(String source) =>
      PickUpOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickUpOrders(orderNo: $orderNo, shipmentPhoto: $shipmentPhoto, orderStatus: $orderStatus, bidCost: $bidCost, timeFrame: $timeFrame, startPoint: $startPoint, destination: $destination, fragile: $fragile, distance: $distance, shipments: $shipments, shipmentWeight: $shipmentWeight, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is PickUpOrders &&
        other.orderNo == orderNo &&
        other.shipmentPhoto == shipmentPhoto &&
        other.orderStatus == orderStatus &&
        other.bidCost == bidCost &&
        other.timeFrame == timeFrame &&
        listEquals(other.startPoint, startPoint) &&
        listEquals(other.destination, destination) &&
        other.fragile == fragile &&
        other.distance == distance &&
        listEquals(other.shipments, shipments) &&
        other.shipmentWeight == shipmentWeight &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return orderNo.hashCode ^
        shipmentPhoto.hashCode ^
        orderStatus.hashCode ^
        bidCost.hashCode ^
        timeFrame.hashCode ^
        startPoint.hashCode ^
        destination.hashCode ^
        fragile.hashCode ^
        distance.hashCode ^
        shipments.hashCode ^
        shipmentWeight.hashCode ^
        userName.hashCode;
  }
}
