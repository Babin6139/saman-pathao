import 'dart:convert';
import 'dart:io';

class Transporters {
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? address;
  String? contactNo;
  String? password;
  String? photo;
  Transporters({
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.address,
    this.contactNo,
    this.password,
    this.photo,
  });

  Transporters copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? address,
    String? contactNo,
    String? password,
    String? photo,
  }) {
    return Transporters(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      contactNo: contactNo ?? this.contactNo,
      password: password ?? this.password,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'contactNo': contactNo,
      'password': password,
      'photo': photo,
    };
  }

  factory Transporters.fromMap(Map<String, dynamic> map) {
    return Transporters(
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      email: map['email'],
      address: map['address'],
      contactNo: map['contactNo'],
      password: map['password'],
      photo: map['photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Transporters.fromJson(String source) =>
      Transporters.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transporters(firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, address: $address, contactNo: $contactNo, password: $password, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transporters &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.email == email &&
        other.address == address &&
        other.contactNo == contactNo &&
        other.password == password &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        contactNo.hashCode ^
        password.hashCode ^
        photo.hashCode;
  }
}
