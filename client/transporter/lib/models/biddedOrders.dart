import 'dart:convert';
import 'dart:ffi';

import 'package:collection/collection.dart';
import 'package:transporter/models/time.dart';

class biddedOrders {
  String orderNo;
  String photo;
  List bids;
  Time biddingTime;
  String maxBudget;
  String orderStatus;
  Time timeFrame;
  String startPoint;
  String destination;
  String weight;
  String distance;
  String fragile;
  biddedOrders({
    required this.orderNo,
    required this.photo,
    required this.bids,
    required this.biddingTime,
    required this.maxBudget,
    required this.orderStatus,
    required this.timeFrame,
    required this.startPoint,
    required this.destination,
    required this.weight,
    required this.distance,
    required this.fragile,
  });

  biddedOrders copyWith({
    String? orderNo,
    String? photo,
    List? bids,
    Time? biddingTime,
    String? maxBudget,
    String? orderStatus,
    Time? timeFrame,
    String? startPoint,
    String? destination,
    String? weight,
    String? distance,
    String? fragile,
  }) {
    return biddedOrders(
      orderNo: orderNo ?? this.orderNo,
      photo: photo ?? this.photo,
      bids: bids ?? this.bids,
      biddingTime: biddingTime ?? this.biddingTime,
      maxBudget: maxBudget ?? this.maxBudget,
      orderStatus: orderStatus ?? this.orderStatus,
      timeFrame: timeFrame ?? this.timeFrame,
      startPoint: startPoint ?? this.startPoint,
      destination: destination ?? this.destination,
      weight: weight ?? this.weight,
      distance: distance ?? this.distance,
      fragile: fragile ?? this.fragile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'photo': photo,
      'bids': bids,
      'biddingTime': biddingTime.toMap(),
      'maxBudget': maxBudget,
      'orderStatus': orderStatus,
      'timeFrame': timeFrame.toMap(),
      'startPoint': startPoint,
      'destination': destination,
      'weight': weight,
      'distance': distance,
      'fragile': fragile,
    };
  }

  factory biddedOrders.fromMap(Map<String, dynamic> map) {
    return biddedOrders(
      orderNo: map['orderNo'] ?? '',
      photo: map['photo'] ?? '',
      bids: List.from(map['bids']),
      biddingTime: Time.fromMap(map['biddingTime']),
      maxBudget: map['maxBudget'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      timeFrame: Time.fromMap(map['timeFrame']),
      startPoint: map['startPoint'] ?? '',
      destination: map['destination'] ?? '',
      weight: map['weight'] ?? '',
      distance: map['distance'] ?? '',
      fragile: map['fragile'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory biddedOrders.fromJson(String source) =>
      biddedOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'biddedOrders(orderNo: $orderNo, photo: $photo, bids: $bids, biddingTime: $biddingTime, maxBudget: $maxBudget, orderStatus: $orderStatus, timeFrame: $timeFrame, startPoint: $startPoint, destination: $destination, weight: $weight, distance: $distance, fragile: $fragile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is biddedOrders &&
        other.orderNo == orderNo &&
        other.photo == photo &&
        listEquals(other.bids, bids) &&
        other.biddingTime == biddingTime &&
        other.maxBudget == maxBudget &&
        other.orderStatus == orderStatus &&
        other.timeFrame == timeFrame &&
        other.startPoint == startPoint &&
        other.destination == destination &&
        other.weight == weight &&
        other.distance == distance &&
        other.fragile == fragile;
  }

  @override
  int get hashCode {
    return orderNo.hashCode ^
        photo.hashCode ^
        bids.hashCode ^
        biddingTime.hashCode ^
        maxBudget.hashCode ^
        orderStatus.hashCode ^
        timeFrame.hashCode ^
        startPoint.hashCode ^
        destination.hashCode ^
        weight.hashCode ^
        distance.hashCode ^
        fragile.hashCode;
  }
}
