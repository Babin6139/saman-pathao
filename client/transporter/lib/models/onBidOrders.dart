import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:transporter/models/bids.dart';
import 'package:transporter/models/time.dart';

class OnBidOrders {
  String orderNo;
  String shipmentPhoto;
  String orderStatus;
  Bids bids;
  Time timeFrame;
  List<String> startPoint;
  List<String> destination;
  bool fragile;
  double distance;
  double maxBudget;
  double minRated;
  List<String> shipments;
  double shipmentWeight;
  Time biddingTime;
  String userName;
  OnBidOrders({
    required this.orderNo,
    required this.shipmentPhoto,
    required this.orderStatus,
    required this.bids,
    required this.timeFrame,
    required this.startPoint,
    required this.destination,
    required this.fragile,
    required this.distance,
    required this.maxBudget,
    required this.minRated,
    required this.shipments,
    required this.shipmentWeight,
    required this.biddingTime,
    required this.userName,
  });

  OnBidOrders copyWith({
    String? orderNo,
    String? shipmentPhoto,
    String? orderStatus,
    Bids? bids,
    Time? timeFrame,
    List<String>? startPoint,
    List<String>? destination,
    bool? fragile,
    double? distance,
    double? maxBudget,
    double? minRated,
    List<String>? shipments,
    double? shipmentWeight,
    Time? biddingTime,
    String? userName,
  }) {
    return OnBidOrders(
      orderNo: orderNo ?? this.orderNo,
      shipmentPhoto: shipmentPhoto ?? this.shipmentPhoto,
      orderStatus: orderStatus ?? this.orderStatus,
      bids: bids ?? this.bids,
      timeFrame: timeFrame ?? this.timeFrame,
      startPoint: startPoint ?? this.startPoint,
      destination: destination ?? this.destination,
      fragile: fragile ?? this.fragile,
      distance: distance ?? this.distance,
      maxBudget: maxBudget ?? this.maxBudget,
      minRated: minRated ?? this.minRated,
      shipments: shipments ?? this.shipments,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
      biddingTime: biddingTime ?? this.biddingTime,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'shipmentPhoto': shipmentPhoto,
      'orderStatus': orderStatus,
      'bids': bids.toMap(),
      'timeFrame': timeFrame.toMap(),
      'startPoint': startPoint,
      'destination': destination,
      'fragile': fragile,
      'distance': distance,
      'maxBudget': maxBudget,
      'minRated': minRated,
      'shipments': shipments,
      'shipmentWeight': shipmentWeight,
      'biddingTime': biddingTime.toMap(),
      'userName': userName,
    };
  }

  factory OnBidOrders.fromMap(Map<String, dynamic> map) {
    return OnBidOrders(
      orderNo: map['orderNo'] ?? '',
      shipmentPhoto: map['shipmentPhoto'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      bids: Bids.fromMap(map['bids']),
      timeFrame: Time.fromMap(map['timeFrame']),
      startPoint: List<String>.from(map['startPoint']),
      destination: List<String>.from(map['destination']),
      fragile: map['fragile'] ?? false,
      distance: map['distance']?.toDouble() ?? 0.0,
      maxBudget: map['maxBudget']?.toDouble() ?? 0.0,
      minRated: map['minRated']?.toDouble() ?? 0.0,
      shipments: List<String>.from(map['shipments']),
      shipmentWeight: map['shipmentWeight']?.toDouble() ?? 0.0,
      biddingTime: Time.fromMap(map['biddingTime']),
      userName: map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OnBidOrders.fromJson(String source) =>
      OnBidOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OnBidOrders(orderNo: $orderNo, shipmentPhoto: $shipmentPhoto, orderStatus: $orderStatus, bids: $bids, timeFrame: $timeFrame, startPoint: $startPoint, destination: $destination, fragile: $fragile, distance: $distance, maxBudget: $maxBudget, minRated: $minRated, shipments: $shipments, shipmentWeight: $shipmentWeight, biddingTime: $biddingTime, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is OnBidOrders &&
        other.orderNo == orderNo &&
        other.shipmentPhoto == shipmentPhoto &&
        other.orderStatus == orderStatus &&
        other.bids == bids &&
        other.timeFrame == timeFrame &&
        listEquals(other.startPoint, startPoint) &&
        listEquals(other.destination, destination) &&
        other.fragile == fragile &&
        other.distance == distance &&
        other.maxBudget == maxBudget &&
        other.minRated == minRated &&
        listEquals(other.shipments, shipments) &&
        other.shipmentWeight == shipmentWeight &&
        other.biddingTime == biddingTime &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return orderNo.hashCode ^
        shipmentPhoto.hashCode ^
        orderStatus.hashCode ^
        bids.hashCode ^
        timeFrame.hashCode ^
        startPoint.hashCode ^
        destination.hashCode ^
        fragile.hashCode ^
        distance.hashCode ^
        maxBudget.hashCode ^
        minRated.hashCode ^
        shipments.hashCode ^
        shipmentWeight.hashCode ^
        biddingTime.hashCode ^
        userName.hashCode;
  }
}
