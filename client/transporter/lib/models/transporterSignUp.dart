import 'dart:convert';

class TransporterSignUp {
  String? firstName;
  String? lastName;
  String? middleName;
  String? email;
  String? password;
  String? contactNo;
  String? address;
  String? photo;
  TransporterSignUp({
    this.firstName,
    this.middleName = "",
    this.lastName,
    this.email,
    this.password,
    this.contactNo,
    this.address,
    this.photo,
  });

  TransporterSignUp copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? contactNo,
    String? address,
    String? photo,
  }) {
    return TransporterSignUp(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      contactNo: contactNo ?? this.contactNo,
      address: address ?? this.address,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'contactNo': contactNo,
      'address': address,
      'photo': photo,
    };
  }

  factory TransporterSignUp.fromMap(Map<String, dynamic> map) {
    return TransporterSignUp(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      contactNo: map['contactNo'] ?? '',
      address: map['address'] ?? '',
      photo: map['photo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterSignUp.fromJson(String source) =>
      TransporterSignUp.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransporterSignUp(firstName: $firstName, lastName: $lastName, email: $email, password: $password, contactNo: $contactNo, address: $address, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransporterSignUp &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.password == password &&
        other.contactNo == contactNo &&
        other.address == address &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        contactNo.hashCode ^
        address.hashCode ^
        photo.hashCode;
  }
}
