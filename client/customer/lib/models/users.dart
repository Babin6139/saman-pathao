import 'dart:convert';
import 'dart:io';

class Users {
  String? imageFile;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? address;
  String? contactNumber;
  String? password;
  Users({
    this.imageFile,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.address,
    this.contactNumber,
    this.password,
  });

  Users copyWith({
    String? imageFile,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? address,
    String? contactNumber,
    String? password,
  }) {
    return Users(
      imageFile: imageFile ?? this.imageFile,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageFile': imageFile,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'contactNumber': contactNumber,
      'password': password,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      imageFile: map['imageFile'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      email: map['email'],
      address: map['address'],
      contactNumber: map['contactNumber'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(imageFile: $imageFile, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, address: $address, contactNumber: $contactNumber, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.imageFile == imageFile &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.email == email &&
        other.address == address &&
        other.contactNumber == contactNumber &&
        other.password == password;
  }

  @override
  int get hashCode {
    return imageFile.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        contactNumber.hashCode ^
        password.hashCode;
  }
}
