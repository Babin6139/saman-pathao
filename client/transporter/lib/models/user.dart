import 'dart:convert';

class Users {
  String firstName;
  String middleName;
  String lastName;
  String contactNo;
  String photo;
  double rating;
  Users({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.contactNo,
    required this.photo,
    required this.rating,
  });

  Users copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? contactNo,
    String? photo,
    double? rating,
  }) {
    return Users(
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
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'contactNo': contactNo,
      'photo': photo,
      'rating': rating,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      contactNo: map['contactNo'] ?? '',
      photo: map['photo'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(firstName: $firstName, middleName: $middleName, lastName: $lastName, contactNo: $contactNo, photo: $photo, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.contactNo == contactNo &&
        other.photo == photo &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        contactNo.hashCode ^
        photo.hashCode ^
        rating.hashCode;
  }
}
