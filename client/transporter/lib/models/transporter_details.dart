import 'dart:convert';

import 'package:collection/collection.dart';

class TransporterDetail {
  String email;
  String address;
  String userName;
  bool verified;
  double securityDeposit;
  String dateCreated;
  int ratedBy;
  int successfullDeliveries;
  // List<String> review;
  String firstName;
  String middleName;
  String lastName;
  List<String> contactNo;
  String photo;
  double rating;
  TransporterDetail({
    required this.email,
    required this.address,
    required this.userName,
    required this.verified,
    required this.securityDeposit,
    required this.dateCreated,
    required this.ratedBy,
    required this.successfullDeliveries,
    // required this.review,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.contactNo,
    required this.photo,
    required this.rating,
  });

  TransporterDetail copyWith({
    String? email,
    String? address,
    String? userName,
    bool? verified,
    double? securityDeposit,
    String? dateCreated,
    int? ratedBy,
    int? successfullDeliveries,
    // List<String>? review,
    String? firstName,
    String? middleName,
    String? lastName,
    List<String>? contactNo,
    String? photo,
    double? rating,
  }) {
    return TransporterDetail(
      email: email ?? this.email,
      address: address ?? this.address,
      userName: userName ?? this.userName,
      verified: verified ?? this.verified,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      dateCreated: dateCreated ?? this.dateCreated,
      ratedBy: ratedBy ?? this.ratedBy,
      successfullDeliveries:
          successfullDeliveries ?? this.successfullDeliveries,
      // review: review ?? this.review,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      contactNo: contactNo ?? this.contactNo,
      photo: photo ?? this.photo,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'address': address,
      'userName': userName,
      'verified': verified,
      'securityDeposit': securityDeposit,
      'dateCreated': dateCreated,
      'ratedBy': ratedBy,
      'successfullDeliveries': successfullDeliveries,
      // 'review': review,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'contactNo': contactNo,
      'photo': photo,
      'rating': rating,
    };
  }

  factory TransporterDetail.fromMap(Map<String, dynamic> map) {
    return TransporterDetail(
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      userName: map['userName'] ?? '',
      verified: map['verified'] ?? false,
      securityDeposit: map['securityDeposit']?.toDouble() ?? 0.0,
      dateCreated: map['dateCreated'] ?? '',
      ratedBy: map['ratedBy']?.toInt() ?? 0,
      successfullDeliveries: map['successfullDeliveries']?.toInt() ?? 0,
      // review: List<String>.from(map['review']),
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      contactNo: List<String>.from(map['contactNo']),
      photo: map['photo'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterDetail.fromJson(String source) =>
      TransporterDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransporterDetail(email: $email, address: $address, userName: $userName, verified: $verified, securityDeposit: $securityDeposit, dateCreated: $dateCreated, ratedBy: $ratedBy, successfullDeliveries: $successfullDeliveries, firstName: $firstName, middleName: $middleName, lastName: $lastName, contactNo: $contactNo, photo: $photo, rating: $rating)';
    //  review: $review
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TransporterDetail &&
        other.email == email &&
        other.address == address &&
        other.userName == userName &&
        other.verified == verified &&
        other.securityDeposit == securityDeposit &&
        other.dateCreated == dateCreated &&
        other.ratedBy == ratedBy &&
        other.successfullDeliveries == successfullDeliveries &&
        // listEquals(other.review, review) &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        listEquals(other.contactNo, contactNo) &&
        other.photo == photo &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        address.hashCode ^
        userName.hashCode ^
        verified.hashCode ^
        securityDeposit.hashCode ^
        dateCreated.hashCode ^
        ratedBy.hashCode ^
        successfullDeliveries.hashCode ^
        // review.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        contactNo.hashCode ^
        photo.hashCode ^
        rating.hashCode;
  }
}
