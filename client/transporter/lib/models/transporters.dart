import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:transporter/models/bidedOrders.dart';
import 'package:transporter/models/onBidOrders.dart';
import 'package:transporter/models/onDeliveryOrders.dart';
import 'package:transporter/models/pickUpOrders.dart';

class Transporters {
  String userName;
  String transporterId;
  String email;
  String photo;
  double inAppCurrency;
  double rating;
  bool verified;
  List<PickUpOrders> pickUpOrders;
  List<BiddedOrders> biddedOrders;
  List<OnDeliveryOrders> onDeliveryOrders;
  List<OnBidOrders> onBidOrders;
  Transporters({
    required this.userName,
    required this.transporterId,
    required this.email,
    required this.photo,
    required this.inAppCurrency,
    required this.rating,
    required this.verified,
    required this.pickUpOrders,
    required this.biddedOrders,
    required this.onDeliveryOrders,
    required this.onBidOrders,
  });

  Transporters copyWith({
    String? userName,
    String? transporterId,
    String? email,
    String? photo,
    double? inAppCurrency,
    double? rating,
    bool? verified,
    List<PickUpOrders>? pickUpOrders,
    List<BiddedOrders>? biddedOrders,
    List<OnDeliveryOrders>? onDeliveryOrders,
    List<OnBidOrders>? onBidOrders,
  }) {
    return Transporters(
      userName: userName ?? this.userName,
      transporterId: transporterId ?? this.transporterId,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      inAppCurrency: inAppCurrency ?? this.inAppCurrency,
      rating: rating ?? this.rating,
      verified: verified ?? this.verified,
      pickUpOrders: pickUpOrders ?? this.pickUpOrders,
      biddedOrders: biddedOrders ?? this.biddedOrders,
      onDeliveryOrders: onDeliveryOrders ?? this.onDeliveryOrders,
      onBidOrders: onBidOrders ?? this.onBidOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'transporterId': transporterId,
      'email': email,
      'photo': photo,
      'inAppCurrency': inAppCurrency,
      'rating': rating,
      'verified': verified,
      'pickUpOrders': pickUpOrders.map((x) => x.toMap()).toList(),
      'biddedOrders': biddedOrders.map((x) => x.toMap()).toList(),
      'onDeliveryOrders': onDeliveryOrders.map((x) => x.toMap()).toList(),
      'onBidOrders': onBidOrders.map((x) => x.toMap()).toList(),
    };
  }

  factory Transporters.fromMap(Map<String, dynamic> map) {
    return Transporters(
      userName: map['userName'] ?? '',
      transporterId: map['transporterId'] ?? '',
      email: map['email'] ?? '',
      photo: map['photo'] ?? '',
      inAppCurrency: map['inAppCurrency']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
      verified: map['verified'] ?? false,
      pickUpOrders: List<PickUpOrders>.from(
          map['pickUpOrders']?.map((x) => PickUpOrders.fromMap(x))),
      biddedOrders: List<BiddedOrders>.from(
          map['biddedOrders']?.map((x) => BiddedOrders.fromMap(x))),
      onDeliveryOrders: List<OnDeliveryOrders>.from(
          map['onDeliveryOrders']?.map((x) => OnDeliveryOrders.fromMap(x))),
      onBidOrders: List<OnBidOrders>.from(
          map['onBidOrders']?.map((x) => OnBidOrders.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transporters.fromJson(String source) =>
      Transporters.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transporters(userName: $userName, transporterId: $transporterId, email: $email, photo: $photo, inAppCurrency: $inAppCurrency, rating: $rating, verified: $verified, pickUpOrders: $pickUpOrders, biddedOrders: $biddedOrders, onDeliveryOrders: $onDeliveryOrders, onBidOrders: $onBidOrders)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Transporters &&
        other.userName == userName &&
        other.transporterId == transporterId &&
        other.email == email &&
        other.photo == photo &&
        other.inAppCurrency == inAppCurrency &&
        other.rating == rating &&
        other.verified == verified &&
        listEquals(other.pickUpOrders, pickUpOrders) &&
        listEquals(other.biddedOrders, biddedOrders) &&
        listEquals(other.onDeliveryOrders, onDeliveryOrders) &&
        listEquals(other.onBidOrders, onBidOrders);
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        transporterId.hashCode ^
        email.hashCode ^
        photo.hashCode ^
        inAppCurrency.hashCode ^
        rating.hashCode ^
        verified.hashCode ^
        pickUpOrders.hashCode ^
        biddedOrders.hashCode ^
        onDeliveryOrders.hashCode ^
        onBidOrders.hashCode;
  }
}
