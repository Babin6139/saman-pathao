import 'dart:convert';
import 'dart:io';

class Users {
  String? photo;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? address;
  String? contactNo;
  String? password;
  Users({
    this.photo,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.address,
    this.contactNo,
    this.password,
  });

  Users copyWith({
    String? photo,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? address,
    String? contactNo,
    String? password,
  }) {
    return Users(
      photo: photo ?? this.photo,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      contactNo: contactNo ?? this.contactNo,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photo': photo,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'contactNo': contactNo,
      'password': password,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      photo: map['photo'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      email: map['email'],
      address: map['address'],
      contactNo: map['contactNo'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(photo: $photo, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, address: $address, contactNo: $contactNo, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.photo == photo &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.email == email &&
        other.address == address &&
        other.contactNo == contactNo &&
        other.password == password;
  }

  @override
  int get hashCode {
    return photo.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        contactNo.hashCode ^
        password.hashCode;
  }
}
