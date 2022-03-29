import 'dart:convert';

import 'package:customer/models/sipment_dimension.dart';
import 'package:customer/models/time_frame.dart';

class PlaceOrderDetail {
  String? userName;
  TimeFrame? timeFrame;
  List? startPoint;
  List? destination;
  TimeFrame? biddingTime;
  int? maxBudget;
  List? shipments;
  double? shipmentWeight;
  ShipmentDimension? shipmentDimension;
  bool? fragile;
  double? minRated;
  String? photo;
  double? distance;
  PlaceOrderDetail({
    this.userName,
    this.timeFrame,
    this.startPoint,
    this.destination,
    this.biddingTime,
    this.maxBudget,
    this.shipments,
    this.shipmentWeight,
    this.shipmentDimension,
    this.fragile,
    this.minRated,
    this.photo,
    this.distance,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'timeFrame': timeFrame?.toMap(),
      'startPoint': startPoint?.asMap(),
      'destination': destination?.asMap(),
      'biddingTime': biddingTime?.toMap(),
      'maxBudget': maxBudget,
      'shipments': shipments?.asMap(),
      'shipmentWeight': shipmentWeight,
      'shipmentDimension': shipmentDimension?.toMap(),
      'fragile': fragile,
      'minRated': minRated,
      'photo': photo,
      'distance': distance,
    };
  }

  factory PlaceOrderDetail.fromMap(Map<String, dynamic> map) {
    return PlaceOrderDetail(
      userName: map['userName'],
      timeFrame:
          map['timeFrame'] != null ? TimeFrame.fromMap(map['timeFrame']) : null,
      startPoint: map['startPoint'] != null ? map['startPoint'] : null,
      destination: map['destination'] != null ? map['destination'] : null,
      biddingTime: map['biddingTime'] != null
          ? TimeFrame.fromMap(map['biddingTime'])
          : null,
      maxBudget: map['maxBudget']?.toInt(),
      shipments: map['shipments'] != null ? map['shipments'] : null,
      shipmentWeight: map['shipmentWeight']?.toDouble(),
      shipmentDimension: map['shipmentDimension'] != null
          ? ShipmentDimension.fromMap(map['shipmentDimension'])
          : null,
      fragile: map['fragile'],
      minRated: map['minRated']?.toDouble(),
      photo: map['photo'],
      distance: map['distance']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceOrderDetail.fromJson(String source) =>
      PlaceOrderDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceOrderDetail(userName: $userName, timeFrame: $timeFrame, startPoint: $startPoint, destination: $destination, biddingTime: $biddingTime, maxBudget: $maxBudget, shipments: $shipments, shipmentWeight: $shipmentWeight, shipmentDimension: $shipmentDimension, fragile: $fragile, minRated: $minRated, photo: $photo, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaceOrderDetail &&
        other.userName == userName &&
        other.timeFrame == timeFrame &&
        other.startPoint == startPoint &&
        other.destination == destination &&
        other.biddingTime == biddingTime &&
        other.maxBudget == maxBudget &&
        other.shipments == shipments &&
        other.shipmentWeight == shipmentWeight &&
        other.shipmentDimension == shipmentDimension &&
        other.fragile == fragile &&
        other.minRated == minRated &&
        other.photo == photo &&
        other.distance == distance;
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
        distance.hashCode;
  }
}
