import 'dart:convert';

import 'package:collection/collection.dart';

class VehicleDetails {
  String? licenseNo;
  String? vehicleNo;
  double? vehicleCapacity;
  List<double> vehicleDimension = [0, 0, 0];
  String? licencePhoto;
  String? blueBookPhoto;
  String? vehiclePhoto;
  String? userName;
  VehicleDetails({
    this.licenseNo,
    this.vehicleNo,
    this.vehicleCapacity,
    required this.vehicleDimension,
    this.licencePhoto,
    this.blueBookPhoto,
    this.vehiclePhoto,
    this.userName,
  });

  VehicleDetails copyWith({
    String? licenseNo,
    String? vehicleNo,
    double? vehicleCapacity,
    List<double>? vehicleDimension,
    String? licencePhoto,
    String? blueBookPhoto,
    String? vehiclePhoto,
    String? userName,
  }) {
    return VehicleDetails(
      licenseNo: licenseNo ?? this.licenseNo,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      vehicleCapacity: vehicleCapacity ?? this.vehicleCapacity,
      vehicleDimension: vehicleDimension ?? this.vehicleDimension,
      licencePhoto: licencePhoto ?? this.licencePhoto,
      blueBookPhoto: blueBookPhoto ?? this.blueBookPhoto,
      vehiclePhoto: vehiclePhoto ?? this.vehiclePhoto,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'licenseNo': licenseNo,
      'vehicleNo': vehicleNo,
      'vehicleCapacity': vehicleCapacity,
      'vehicleDimension': vehicleDimension,
      'licencePhoto': licencePhoto,
      'blueBookPhoto': blueBookPhoto,
      'vehiclePhoto': vehiclePhoto,
      'userName': userName,
    };
  }

  factory VehicleDetails.fromMap(Map<String, dynamic> map) {
    return VehicleDetails(
      licenseNo: map['licenseNo'],
      vehicleNo: map['vehicleNo'],
      vehicleCapacity: map['vehicleCapacity']?.toDouble(),
      vehicleDimension: List<double>.from(map['vehicleDimension']),
      licencePhoto: map['licencePhoto'],
      blueBookPhoto: map['blueBookPhoto'],
      vehiclePhoto: map['vehiclePhoto'],
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleDetails.fromJson(String source) =>
      VehicleDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VehicleDetails(licenseNo: $licenseNo, vehicleNo: $vehicleNo, vehicleCapacity: $vehicleCapacity, vehicleDimension: $vehicleDimension, licencePhoto: $licencePhoto, blueBookPhoto: $blueBookPhoto, vehiclePhoto: $vehiclePhoto, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is VehicleDetails &&
        other.licenseNo == licenseNo &&
        other.vehicleNo == vehicleNo &&
        other.vehicleCapacity == vehicleCapacity &&
        listEquals(other.vehicleDimension, vehicleDimension) &&
        other.licencePhoto == licencePhoto &&
        other.blueBookPhoto == blueBookPhoto &&
        other.vehiclePhoto == vehiclePhoto &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return licenseNo.hashCode ^
        vehicleNo.hashCode ^
        vehicleCapacity.hashCode ^
        vehicleDimension.hashCode ^
        licencePhoto.hashCode ^
        blueBookPhoto.hashCode ^
        vehiclePhoto.hashCode ^
        userName.hashCode;
  }
}
