import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:customer/models/bids.dart';
import 'package:customer/models/sipment_dimension.dart';
import 'package:customer/models/time_frame.dart';

class OrderModel {
  final TimeFrame timeFrame;
  final TimeFrame biddingTime;
  final ShipmentDimension shipmentDimension;
  final bool verifiedByClient;
  final String id;
  final String orderStatus;
  final List<String> startPoint;
  final List<String> destination;
  final double distance;
  final int maxBudget;
  final List<String> shipments;
  final double shipmentWeight;
  final bool fragile;
  final Bids bids;
  final double minRated;
  final bool bidConfirmed;
  final List timeLocation;
  final String shipmentPhoto;
  final int v;
  OrderModel({
    required this.timeFrame,
    required this.biddingTime,
    required this.shipmentDimension,
    required this.verifiedByClient,
    required this.id,
    required this.orderStatus,
    required this.startPoint,
    required this.destination,
    required this.distance,
    required this.maxBudget,
    required this.shipments,
    required this.shipmentWeight,
    required this.fragile,
    required this.bids,
    required this.minRated,
    required this.bidConfirmed,
    required this.timeLocation,
    required this.shipmentPhoto,
    required this.v,
  });

  OrderModel copyWith({
    TimeFrame? timeFrame,
    TimeFrame? biddingTime,
    ShipmentDimension? shipmentDimension,
    bool? verifiedByClient,
    String? id,
    String? orderStatus,
    List<String>? startPoint,
    List<String>? destination,
    double? distance,
    int? maxBudget,
    List<String>? shipments,
    double? shipmentWeight,
    bool? fragile,
    Bids? bids,
    double? minRated,
    bool? bidConfirmed,
    List? timeLocation,
    String? shipmentPhoto,
    int? v,
  }) {
    return OrderModel(
      timeFrame: timeFrame ?? this.timeFrame,
      biddingTime: biddingTime ?? this.biddingTime,
      shipmentDimension: shipmentDimension ?? this.shipmentDimension,
      verifiedByClient: verifiedByClient ?? this.verifiedByClient,
      id: id ?? this.id,
      orderStatus: orderStatus ?? this.orderStatus,
      startPoint: startPoint ?? this.startPoint,
      destination: destination ?? this.destination,
      distance: distance ?? this.distance,
      maxBudget: maxBudget ?? this.maxBudget,
      shipments: shipments ?? this.shipments,
      shipmentWeight: shipmentWeight ?? this.shipmentWeight,
      fragile: fragile ?? this.fragile,
      bids: bids ?? this.bids,
      minRated: minRated ?? this.minRated,
      bidConfirmed: bidConfirmed ?? this.bidConfirmed,
      timeLocation: timeLocation ?? this.timeLocation,
      shipmentPhoto: shipmentPhoto ?? this.shipmentPhoto,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeFrame': timeFrame.toMap(),
      'biddingTime': biddingTime.toMap(),
      'shipmentDimension': shipmentDimension.toMap(),
      'verifiedByClient': verifiedByClient,
      'id': id,
      'orderStatus': orderStatus,
      'startPoint': startPoint,
      'destination': destination,
      'distance': distance,
      'maxBudget': maxBudget,
      'shipments': shipments,
      'shipmentWeight': shipmentWeight,
      'fragile': fragile,
      'bids': bids.toMap(),
      'minRated': minRated,
      'bidConfirmed': bidConfirmed,
      'timeLocation': timeLocation,
      'shipmentPhoto': shipmentPhoto,
      'v': v,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      timeFrame: TimeFrame.fromMap(map['timeFrame']),
      biddingTime: TimeFrame.fromMap(map['biddingTime']),
      shipmentDimension: ShipmentDimension.fromMap(map['shipmentDimension']),
      verifiedByClient: map['verifiedByClient'] ?? false,
      id: map['_id'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      startPoint: List<String>.from(map['startPoint']),
      destination: List<String>.from(map['destination']),
      distance: map['distance']?.toDouble() ?? 0.0,
      maxBudget: map['maxBudget']?.toInt() ?? 0,
      shipments: List<String>.from(map['shipments']),
      shipmentWeight: map['shipmentWeight']?.toDouble() ?? 0.0,
      fragile: map['fragile'] ?? false,
      bids: Bids.fromMap(map['bids']),
      minRated: map['minRated']?.toDouble() ?? 0.0,
      bidConfirmed: map['bidConfirmed'] ?? false,
      timeLocation: List.from(map['timeLocation']),
      shipmentPhoto: map['shipmentPhoto'] ?? '',
      v: map['__v']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(timeFrame: $timeFrame, biddingTime: $biddingTime, shipmentDimension: $shipmentDimension, verifiedByClient: $verifiedByClient, id: $id, orderStatus: $orderStatus, startPoint: $startPoint, destination: $destination, distance: $distance, maxBudget: $maxBudget, shipments: $shipments, shipmentWeight: $shipmentWeight, fragile: $fragile, bids: $bids, minRated: $minRated, bidConfirmed: $bidConfirmed, timeLocation: $timeLocation, shipmentPhoto: $shipmentPhoto, v: $v)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is OrderModel &&
        other.timeFrame == timeFrame &&
        other.biddingTime == biddingTime &&
        other.shipmentDimension == shipmentDimension &&
        other.verifiedByClient == verifiedByClient &&
        other.id == id &&
        other.orderStatus == orderStatus &&
        listEquals(other.startPoint, startPoint) &&
        listEquals(other.destination, destination) &&
        other.distance == distance &&
        other.maxBudget == maxBudget &&
        listEquals(other.shipments, shipments) &&
        other.shipmentWeight == shipmentWeight &&
        other.fragile == fragile &&
        other.bids == bids &&
        other.minRated == minRated &&
        other.bidConfirmed == bidConfirmed &&
        listEquals(other.timeLocation, timeLocation) &&
        other.shipmentPhoto == shipmentPhoto &&
        other.v == v;
  }

  @override
  int get hashCode {
    return timeFrame.hashCode ^
        biddingTime.hashCode ^
        shipmentDimension.hashCode ^
        verifiedByClient.hashCode ^
        id.hashCode ^
        orderStatus.hashCode ^
        startPoint.hashCode ^
        destination.hashCode ^
        distance.hashCode ^
        maxBudget.hashCode ^
        shipments.hashCode ^
        shipmentWeight.hashCode ^
        fragile.hashCode ^
        bids.hashCode ^
        minRated.hashCode ^
        bidConfirmed.hashCode ^
        timeLocation.hashCode ^
        shipmentPhoto.hashCode ^
        v.hashCode;
  }
}
