import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:customer/models/sipment_dimension.dart';
import 'package:customer/models/time_frame.dart';

class PlaceOrderDetail {
  String? userName;
  TimeFrame? timeFrame;
  List startPoint;
  List destination;
  TimeFrame? biddingTime;
  int? maxBudget;
  List shipments;
  double? shipmentWeight;
  ShipmentDimension? shipmentDimension;
  bool? fragile;
  double? minRated;
  String? shipmentPhoto;
  double? distance;
  String? email;
  String? orderNo;
  List shipmentCount;
  PlaceOrderDetail({
    this.userName,
    this.timeFrame,
    required this.startPoint,
    required this.destination,
    this.biddingTime,
    this.maxBudget,
    required this.shipments,
    this.shipmentWeight,
    this.shipmentDimension,
    this.fragile,
    this.minRated,
    this.shipmentPhoto,
    this.distance,
    this.email,
    this.orderNo,
    required this.shipmentCount,
  });

  PlaceOrderDetail copyWith({
    String? userName,
    TimeFrame? timeFrame,
    List? startPoint,
    List? destination,
    TimeFrame? biddingTime,
    int? maxBudget,
    List? shipments,
    double? shipmentWeight,
    ShipmentDimension? shipmentDimension,
    bool? fragile,
    double? minRated,
    String? shipmentPhoto,
    double? distance,
    String? email,
    String? orderNo,
    List? shipmentCount,
  }) {
    return PlaceOrderDetail(
      userName: userName ?? this.userName,
      timeFrame: timeFrame ?? this.timeFrame,
      startPoint: startPoint ?? this.startPoint,
      destination: destination ?? this.destination,
      biddingTime: biddingTime ?? this.biddingTime,
      maxBudget: maxBudget ?? this.maxBudget,
      shipments: shipments ?? this.shipments,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
      shipmentDimension: shipmentDimension ?? this.shipmentDimension,
      fragile: fragile ?? this.fragile,
      minRated: minRated ?? this.minRated,
      shipmentPhoto: shipmentPhoto ?? this.shipmentPhoto,
      distance: distance ?? this.distance,
      email: email ?? this.email,
      orderNo: orderNo ?? this.orderNo,
      shipmentCount: shipmentCount ?? this.shipmentCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (userName != null) {
      result.addAll({'userName': userName});
    }
    if (timeFrame != null) {
      result.addAll({'timeFrame': timeFrame!.toMap()});
    }
    result.addAll({'startPoint': startPoint});
    result.addAll({'destination': destination});
    if (biddingTime != null) {
      result.addAll({'biddingTime': biddingTime!.toMap()});
    }
    if (maxBudget != null) {
      result.addAll({'maxBudget': maxBudget});
    }
    result.addAll({'shipments': shipments});
    if (shipmentWeight != null) {
      result.addAll({'shipmentWeight': shipmentWeight});
    }
    if (shipmentDimension != null) {
      result.addAll({'shipmentDimension': shipmentDimension!.toMap()});
    }
    if (fragile != null) {
      result.addAll({'fragile': fragile});
    }
    if (minRated != null) {
      result.addAll({'minRated': minRated});
    }
    if (shipmentPhoto != null) {
      result.addAll({'shipmentPhoto': shipmentPhoto});
    }
    if (distance != null) {
      result.addAll({'distance': distance});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (orderNo != null) {
      result.addAll({'orderNo': orderNo});
    }
    result.addAll({'shipmentCount': shipmentCount});

    return result;
  }

  factory PlaceOrderDetail.fromMap(Map<String, dynamic> map) {
    return PlaceOrderDetail(
      userName: map['userName'],
      timeFrame:
          map['timeFrame'] != null ? TimeFrame.fromMap(map['timeFrame']) : null,
      startPoint: List.from(map['startPoint']),
      destination: List.from(map['destination']),
      biddingTime: map['biddingTime'] != null
          ? TimeFrame.fromMap(map['biddingTime'])
          : null,
      maxBudget: map['maxBudget']?.toInt(),
      shipments: List.from(map['shipments']),
      shipmentWeight: map['shipmentWeight']?.toDouble(),
      shipmentDimension: map['shipmentDimension'] != null
          ? ShipmentDimension.fromMap(map['shipmentDimension'])
          : null,
      fragile: map['fragile'],
      minRated: map['minRated']?.toDouble(),
      shipmentPhoto: map['shipmentPhoto'],
      distance: map['distance']?.toDouble(),
      email: map['email'],
      orderNo: map['orderNo'],
      shipmentCount: List.from(map['shipmentCount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceOrderDetail.fromJson(String source) =>
      PlaceOrderDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceOrderDetail(userName: $userName, timeFrame: $timeFrame, startPoint: $startPoint, destination: $destination, biddingTime: $biddingTime, maxBudget: $maxBudget, shipments: $shipments, shipmentWeight: $shipmentWeight, shipmentDimension: $shipmentDimension, fragile: $fragile, minRated: $minRated, shipmentPhoto: $shipmentPhoto, distance: $distance, email: $email, orderNo: $orderNo, shipmentCount: $shipmentCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is PlaceOrderDetail &&
        other.userName == userName &&
        other.timeFrame == timeFrame &&
        listEquals(other.startPoint, startPoint) &&
        listEquals(other.destination, destination) &&
        other.biddingTime == biddingTime &&
        other.maxBudget == maxBudget &&
        listEquals(other.shipments, shipments) &&
        other.shipmentWeight == shipmentWeight &&
        other.shipmentDimension == shipmentDimension &&
        other.fragile == fragile &&
        other.minRated == minRated &&
        other.shipmentPhoto == shipmentPhoto &&
        other.distance == distance &&
        other.email == email &&
        other.orderNo == orderNo &&
        listEquals(other.shipmentCount, shipmentCount);
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        timeFrame.hashCode ^
        startPoint.hashCode ^
        destination.hashCode ^
        biddingTime.hashCode ^
        maxBudget.hashCode ^
        shipments.hashCode ^
        shipmentWeight.hashCode ^
        shipmentDimension.hashCode ^
        fragile.hashCode ^
        minRated.hashCode ^
        shipmentPhoto.hashCode ^
        distance.hashCode ^
        email.hashCode ^
        orderNo.hashCode ^
        shipmentCount.hashCode;
  }
}
