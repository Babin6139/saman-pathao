import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:transporter/models/bids.dart';
import 'package:transporter/models/time.dart';

class BiddedOrders {
  String orderNo;
  Time biddingTime;
  String shipmentPhoto;
  double maxBudget;
  String orderStatus;
  Bids bids;
  Time timeFrame;
  List<String> destination;
  List<String> startPoint;
  bool fragile;
  double distance;
  List<String> shipments;
  double shipmentWeight;
  BiddedOrders({
    required this.orderNo,
    required this.biddingTime,
    required this.shipmentPhoto,
    required this.maxBudget,
    required this.orderStatus,
    required this.bids,
    required this.timeFrame,
    required this.destination,
    required this.startPoint,
    required this.fragile,
    required this.distance,
    required this.shipments,
    required this.shipmentWeight,
  });

  BiddedOrders copyWith({
    String? orderNo,
    Time? biddingTime,
    String? shipmentPhoto,
    double? maxBudget,
    String? orderStatus,
    Bids? bids,
    Time? timeFrame,
    List<String>? destination,
    List<String>? startPoint,
    bool? fragile,
    double? distance,
    List<String>? shipments,
    double? shipmentWeight,
  }) {
    return BiddedOrders(
      orderNo: orderNo ?? this.orderNo,
      biddingTime: biddingTime ?? this.biddingTime,
      shipmentPhoto: shipmentPhoto ?? this.shipmentPhoto,
      maxBudget: maxBudget ?? this.maxBudget,
      orderStatus: orderStatus ?? this.orderStatus,
      bids: bids ?? this.bids,
      timeFrame: timeFrame ?? this.timeFrame,
      destination: destination ?? this.destination,
      startPoint: startPoint ?? this.startPoint,
      fragile: fragile ?? this.fragile,
      distance: distance ?? this.distance,
      shipments: shipments ?? this.shipments,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'biddingTime': biddingTime.toMap(),
      'shipmentPhoto': shipmentPhoto,
      'maxBudget': maxBudget,
      'orderStatus': orderStatus,
      'bids': bids.toMap(),
      'timeFrame': timeFrame.toMap(),
      'destination': destination,
      'startPoint': startPoint,
      'fragile': fragile,
      'distance': distance,
      'shipments': shipments,
      'shipmentWeight': shipmentWeight,
    };
  }

  factory BiddedOrders.fromMap(Map<String, dynamic> map) {
    return BiddedOrders(
      orderNo: map['orderNo'] ?? '',
      biddingTime: Time.fromMap(map['biddingTime']),
      shipmentPhoto: map['shipmentPhoto'] ?? '',
      maxBudget: map['maxBudget']?.toDouble() ?? 0.0,
      orderStatus: map['orderStatus'] ?? '',
      bids: Bids.fromMap(map['bids']),
      timeFrame: Time.fromMap(map['timeFrame']),
      destination: List<String>.from(map['destination']),
      startPoint: List<String>.from(map['startPoint']),
      fragile: map['fragile'] ?? false,
      distance: map['distance']?.toDouble() ?? 0.0,
      shipments: List<String>.from(map['shipments']),
      shipmentWeight: map['shipmentWeight']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BiddedOrders.fromJson(String source) =>
      BiddedOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BiddedOrders(orderNo: $orderNo, biddingTime: $biddingTime, shipmentPhoto: $shipmentPhoto, maxBudget: $maxBudget, orderStatus: $orderStatus, bids: $bids, timeFrame: $timeFrame, destination: $destination, startPoint: $startPoint, fragile: $fragile, distance: $distance, shipments: $shipments, shipmentWeight: $shipmentWeight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is BiddedOrders &&
        other.orderNo == orderNo &&
        other.biddingTime == biddingTime &&
        other.shipmentPhoto == shipmentPhoto &&
        other.maxBudget == maxBudget &&
        other.orderStatus == orderStatus &&
        other.bids == bids &&
        other.timeFrame == timeFrame &&
        listEquals(other.destination, destination) &&
        listEquals(other.startPoint, startPoint) &&
        other.fragile == fragile &&
        other.distance == distance &&
        listEquals(other.shipments, shipments) &&
        other.shipmentWeight == shipmentWeight;
  }

  @override
  int get hashCode {
    return orderNo.hashCode ^
        biddingTime.hashCode ^
        shipmentPhoto.hashCode ^
        maxBudget.hashCode ^
        orderStatus.hashCode ^
        bids.hashCode ^
        timeFrame.hashCode ^
        destination.hashCode ^
        startPoint.hashCode ^
        fragile.hashCode ^
        distance.hashCode ^
        shipments.hashCode ^
        shipmentWeight.hashCode;
  }
}
