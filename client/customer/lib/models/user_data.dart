import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:customer/models/user_orders.dart';

class UserData {
  final String userName;
  final String email;
  final String photo;
  final int inAppCurrency;
  final int rating;
  final List<UserOrders> postBidOrders;
  final List<UserOrders> onBidOrders;
  final List<UserOrders> onDeliveryOrders;
  UserData({
    required this.userName,
    required this.email,
    required this.photo,
    required this.inAppCurrency,
    required this.rating,
    required this.postBidOrders,
    required this.onBidOrders,
    required this.onDeliveryOrders,
  });

  UserData copyWith({
    String? userName,
    String? email,
    String? photo,
    int? inAppCurrency,
    int? rating,
    List<UserOrders>? postBidOrders,
    List<UserOrders>? onBidOrders,
    List<UserOrders>? onDeliveryOrders,
  }) {
    return UserData(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      inAppCurrency: inAppCurrency ?? this.inAppCurrency,
      rating: rating ?? this.rating,
      postBidOrders: postBidOrders ?? this.postBidOrders,
      onBidOrders: onBidOrders ?? this.onBidOrders,
      onDeliveryOrders: onDeliveryOrders ?? this.onDeliveryOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'photo': photo,
      'inAppCurrency': inAppCurrency,
      'rating': rating,
      'postBidOrders': postBidOrders.map((x) => x.toMap()).toList(),
      'onBidOrders': onBidOrders.map((x) => x.toMap()).toList(),
      'onDeliveryOrders': onDeliveryOrders.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      photo: map['photo'] ?? '',
      inAppCurrency: map['inAppCurrency']?.toInt() ?? 0,
      rating: map['rating']?.toInt() ?? 0,
      postBidOrders: List<UserOrders>.from(
          map['postBidOrders']?.map((x) => UserOrders.fromMap(x))),
      onBidOrders: List<UserOrders>.from(
          map['onBidOrders']?.map((x) => UserOrders.fromMap(x))),
      onDeliveryOrders: List<UserOrders>.from(
          map['onDeliveryOrders']?.map((x) => UserOrders.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(userName: $userName, email: $email, photo: $photo, inAppCurrency: $inAppCurrency, rating: $rating, postBidOrders: $postBidOrders, onBidOrders: $onBidOrders, onDeliveryOrders: $onDeliveryOrders)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UserData &&
        other.userName == userName &&
        other.email == email &&
        other.photo == photo &&
        other.inAppCurrency == inAppCurrency &&
        other.rating == rating &&
        listEquals(other.postBidOrders, postBidOrders) &&
        listEquals(other.onBidOrders, onBidOrders) &&
        listEquals(other.onDeliveryOrders, onDeliveryOrders);
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        email.hashCode ^
        photo.hashCode ^
        inAppCurrency.hashCode ^
        rating.hashCode ^
        postBidOrders.hashCode ^
        onBidOrders.hashCode ^
        onDeliveryOrders.hashCode;
  }
}
