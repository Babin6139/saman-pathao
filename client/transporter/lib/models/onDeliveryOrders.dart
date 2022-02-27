import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:transporter/models/time.dart';

class OnDeliveryOrders {
  String orderNo;
  String shipmentPhoto;
  String orderStatus;
  double bidCost;
  Time timeFrame;
  List<String> startPoint;
  List<String> destination;
  double distance;
  List<String> shipments;
  double shipmentWeight;
  String pickedUpTime;
  OnDeliveryOrders({
    required this.orderNo,
    required this.shipmentPhoto,
    required this.orderStatus,
    required this.bidCost,
    required this.timeFrame,
    required this.startPoint,
    required this.destination,
    required this.distance,
    required this.shipments,
    required this.shipmentWeight,
    required this.pickedUpTime,
  });

  OnDeliveryOrders copyWith({
    String? orderNo,
    String? shipmentPhoto,
    String? orderStatus,
    double? bidCost,
    Time? timeFrame,
    List<String>? startPoint,
    List<String>? destination,
    double? distance,
    List<String>? shipments,
    double? shipmentWeight,
    String? pickedUpTime,
  }) {
    return OnDeliveryOrders(
      orderNo: orderNo ?? this.orderNo,
      shipmentPhoto: shipmentPhoto ?? this.shipmentPhoto,
      orderStatus: orderStatus ?? this.orderStatus,
      bidCost: bidCost ?? this.bidCost,
      timeFrame: timeFrame ?? this.timeFrame,
      startPoint: startPoint ?? this.startPoint,
      destination: destination ?? this.destination,
      distance: distance ?? this.distance,
      shipments: shipments ?? this.shipments,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
      pickedUpTime: pickedUpTime ?? this.pickedUpTime,
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
      'distance': distance,
      'shipments': shipments,
      'shipmentWeight': shipmentWeight,
      'pickedUpTime': pickedUpTime,
    };
  }

  factory OnDeliveryOrders.fromMap(Map<String, dynamic> map) {
    return OnDeliveryOrders(
      orderNo: map['orderNo'] ?? '',
      shipmentPhoto: map['shipmentPhoto'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      bidCost: map['bidCost']?.toDouble() ?? 0.0,
      timeFrame: Time.fromMap(map['timeFrame']),
      startPoint: List<String>.from(map['startPoint']),
      destination: List<String>.from(map['destination']),
      distance: map['distance']?.toDouble() ?? 0.0,
      shipments: List<String>.from(map['shipments']),
      shipmentWeight: map['shipmentWeight']?.toDouble() ?? 0.0,
      pickedUpTime: map['pickedUpTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OnDeliveryOrders.fromJson(String source) =>
      OnDeliveryOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OnDeliveryOrders(orderNo: $orderNo, shipmentPhoto: $shipmentPhoto, orderStatus: $orderStatus, bidCost: $bidCost, timeFrame: $timeFrame, startPoint: $startPoint, destination: $destination, distance: $distance, shipments: $shipments, shipmentWeight: $shipmentWeight, pickedUpTime: $pickedUpTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is OnDeliveryOrders &&
        other.orderNo == orderNo &&
        other.shipmentPhoto == shipmentPhoto &&
        other.orderStatus == orderStatus &&
        other.bidCost == bidCost &&
        other.timeFrame == timeFrame &&
        listEquals(other.startPoint, startPoint) &&
        listEquals(other.destination, destination) &&
        other.distance == distance &&
        listEquals(other.shipments, shipments) &&
        other.shipmentWeight == shipmentWeight &&
        other.pickedUpTime == pickedUpTime;
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
        distance.hashCode ^
        shipments.hashCode ^
        shipmentWeight.hashCode ^
        pickedUpTime.hashCode;
  }
}
