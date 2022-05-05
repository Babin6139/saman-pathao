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
  String? photo;
  double? distance;
  String? email;
  String? orderNo;
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
    this.photo,
    this.distance,
    this.email,
    this.orderNo,
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
    String? photo,
    double? distance,
    String? email,
    String? orderNo,
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
      photo: photo ?? this.photo,
      distance: distance ?? this.distance,
      email: email ?? this.email,
      orderNo: orderNo ?? this.orderNo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'timeFrame': timeFrame?.toMap(),
      'startPoint': startPoint,
      'destination': destination,
      'biddingTime': biddingTime?.toMap(),
      'maxBudget': maxBudget,
      'shipments': shipments,
      'shipmentWeight': shipmentWeight,
      'shipmentDimension': shipmentDimension?.toMap(),
      'fragile': fragile,
      'minRated': minRated,
      'photo': photo,
      'distance': distance,
      'email': email,
      'orderNo': orderNo,
    };
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
      photo: map['photo'],
      distance: map['distance']?.toDouble(),
      email: map['email'],
      orderNo: map['orderNo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceOrderDetail.fromJson(String source) =>
      PlaceOrderDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceOrderDetail(userName: $userName, timeFrame: $timeFrame, startPoint: $startPoint, destination: $destination, biddingTime: $biddingTime, maxBudget: $maxBudget, shipments: $shipments, shipmentWeight: $shipmentWeight, shipmentDimension: $shipmentDimension, fragile: $fragile, minRated: $minRated, photo: $photo, distance: $distance, email: $email, orderNo: $orderNo)';
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
        other.photo == photo &&
        other.distance == distance &&
        other.email == email &&
        other.orderNo == orderNo;
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
        photo.hashCode ^
        distance.hashCode ^
        email.hashCode ^
        orderNo.hashCode;
  }
}
