import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:transporter/models/dimension.dart';
import 'package:transporter/models/time.dart';

class TransporterOrders {
  String orderNumber;
  String orderStatus;
  Time timeFrame;
  double distance;
  Time biddingTime;
  double maxBudget;
  List<String> shipments;
  String shipmentPhoto;
  double shipmentWeight;
  Dimension shipmentDimension;
  bool fragile;
  List<double> bidAmount;
  // Time pickedUpTime;
  double bidCost;
  TransporterOrders({
    required this.orderNumber,
    required this.orderStatus,
    required this.timeFrame,
    required this.distance,
    required this.biddingTime,
    required this.maxBudget,
    required this.shipments,
    required this.shipmentPhoto,
    required this.shipmentWeight,
    required this.shipmentDimension,
    required this.fragile,
    required this.bidAmount,
    // required this.pickedUpTime,
    required this.bidCost,
  });

  TransporterOrders copyWith({
    String? orderNumber,
    String? orderStatus,
    Time? timeFrame,
    double? distance,
    Time? biddingTime,
    double? maxBudget,
    List<String>? shipments,
    String? shipmentPhoto,
    double? shipmentWeight,
    Dimension? shipmentDimension,
    bool? fragile,
    List<double>? bidAmount,
    // Time? pickedUpTime,
    double? bidCost,
  }) {
    return TransporterOrders(
      orderNumber: orderNumber ?? this.orderNumber,
      orderStatus: orderStatus ?? this.orderStatus,
      timeFrame: timeFrame ?? this.timeFrame,
      distance: distance ?? this.distance,
      biddingTime: biddingTime ?? this.biddingTime,
      maxBudget: maxBudget ?? this.maxBudget,
      shipments: shipments ?? this.shipments,
      shipmentPhoto: shipmentPhoto ?? this.shipmentPhoto,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
      shipmentDimension: shipmentDimension ?? this.shipmentDimension,
      fragile: fragile ?? this.fragile,
      bidAmount: bidAmount ?? this.bidAmount,
      // // // pickedUpTime: pickedUpTime ?? this.pickedUpTime,
      bidCost: bidCost ?? this.bidCost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNumber': orderNumber,
      'orderStatus': orderStatus,
      'timeFrame': timeFrame.toMap(),
      'distance': distance,
      'biddingTime': biddingTime.toMap(),
      'maxBudget': maxBudget,
      'shipments': shipments,
      'shipmentPhoto': shipmentPhoto,
      'shipmentWeight': shipmentWeight,
      'shipmentDimension': shipmentDimension.toMap(),
      'fragile': fragile,
      'bidAmount': bidAmount,
      // // 'pickedUpTime': pickedUpTime.toMap(),
      'bidCost': bidCost,
    };
  }

  factory TransporterOrders.fromMap(Map<String, dynamic> map) {
    return TransporterOrders(
      orderNumber: map['orderNumber'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      timeFrame: Time.fromMap(map['timeFrame']),
      distance: map['distance']?.toDouble() ?? 0.0,
      biddingTime: Time.fromMap(map['biddingTime']),
      maxBudget: map['maxBudget']?.toDouble() ?? 0.0,
      shipments: List<String>.from(map['shipments']),
      shipmentPhoto: map['shipmentPhoto'] ?? '',
      shipmentWeight: map['shipmentWeight']?.toDouble() ?? 0.0,
      shipmentDimension: Dimension.fromMap(map['shipmentDimension']),
      fragile: map['fragile'] ?? false,
      bidAmount: List<double>.from(map['bidAmount'] ?? [1.0, 2.0, 3.0, 4.0]),
      // // pickedUpTime: Time.fromMap(map['pickedUpTime']),
      bidCost: map['bidCost']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterOrders.fromJson(String source) =>
      TransporterOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransporterOrders(orderNumber: $orderNumber, orderStatus: $orderStatus, timeFrame: $timeFrame, distance: $distance, biddingTime: $biddingTime, maxBudget: $maxBudget, shipments: $shipments, shipmentPhoto: $shipmentPhoto, shipmentWeight: $shipmentWeight, shipmentDimension: $shipmentDimension, fragile: $fragile, bidAmount: $bidAmount,bidCost: $bidCost)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TransporterOrders &&
        other.orderNumber == orderNumber &&
        other.orderStatus == orderStatus &&
        other.timeFrame == timeFrame &&
        other.distance == distance &&
        other.biddingTime == biddingTime &&
        other.maxBudget == maxBudget &&
        listEquals(other.shipments, shipments) &&
        other.shipmentPhoto == shipmentPhoto &&
        other.shipmentWeight == shipmentWeight &&
        other.shipmentDimension == shipmentDimension &&
        other.fragile == fragile &&
        listEquals(other.bidAmount, bidAmount) &&
        // // other.pickedUpTime == pickedUpTime &&
        other.bidCost == bidCost;
  }

  @override
  int get hashCode {
    return orderNumber.hashCode ^
        orderStatus.hashCode ^
        timeFrame.hashCode ^
        distance.hashCode ^
        biddingTime.hashCode ^
        maxBudget.hashCode ^
        shipments.hashCode ^
        shipmentPhoto.hashCode ^
        shipmentWeight.hashCode ^
        shipmentDimension.hashCode ^
        fragile.hashCode ^
        bidAmount.hashCode ^
        // pickedUpTime.hashCode ^
        bidCost.hashCode;
  }
}
