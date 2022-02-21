import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:customer/models/user_orders.dart';

class UserModel {
  static UserData user = UserData(
      userName: "User",
      email: "user@email.com",
      photo: "photo",
      inAppCurrency: -1,
      rating: -1,
      orders: []);
}

class UserData {
  final String? userName;
  final String? email;
  final String? photo;
  final int? inAppCurrency;
  final int? rating;
  final List<UserOrders>? orders;
  UserData({
    this.userName,
    this.email,
    this.photo,
    this.inAppCurrency,
    this.rating,
    this.orders,
  });

  UserData copyWith({
    String? userName,
    String? email,
    String? photo,
    int? inAppCurrency,
    int? rating,
    List<UserOrders>? orders,
  }) {
    return UserData(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      inAppCurrency: inAppCurrency ?? this.inAppCurrency,
      rating: rating ?? this.rating,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'photo': photo,
      'inAppCurrency': inAppCurrency,
      'rating': rating,
      'orders': orders?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      userName: map['userName'],
      email: map['email'],
      photo: map['photo'],
      inAppCurrency: map['inAppCurrency']?.toInt(),
      rating: map['rating']?.toInt(),
      orders: map['orders'] != null
          ? List<UserOrders>.from(
              map['orders']?.map((x) => UserOrders.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(userName: $userName, email: $email, photo: $photo, inAppCurrency: $inAppCurrency, rating: $rating, orders: $orders)';
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
        listEquals(other.orders, orders);
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        email.hashCode ^
        photo.hashCode ^
        inAppCurrency.hashCode ^
        rating.hashCode ^
        orders.hashCode;
  }
}
