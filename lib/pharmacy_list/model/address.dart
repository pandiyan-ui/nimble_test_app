import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Address extends Equatable {
  final String? streetAddress1;
  final String? city;
  final String? usTerritory;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final String? addressType;
  final String? externalId;
  final bool? isValid;
  final String? googlePlaceId;

  const Address(
      {this.streetAddress1,
      this.city,
      this.usTerritory,
      this.postalCode,
      this.latitude,
      this.longitude,
      this.addressType,
      this.externalId,
      this.isValid,
      this.googlePlaceId});

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      streetAddress1: map['streetAddress1'],
      city: map['city'],
      usTerritory: map['usTerritory'],
      postalCode: map['postalCode'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      addressType: map['addressType'],
      externalId: map['externalId'],
      isValid: map['isValid'],
      googlePlaceId: map['googlePlaceId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetAddress1'] = this.streetAddress1;
    data['city'] = this.city;
    data['usTerritory'] = this.usTerritory;
    data['postalCode'] = this.postalCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['addressType'] = this.addressType;
    data['externalId'] = this.externalId;
    data['isValid'] = this.isValid;
    data['googlePlaceId'] = this.googlePlaceId;
    return data;
  }

  @override
  List<Object?> get props => [
        streetAddress1,
        city,
        usTerritory,
        postalCode,
        latitude,
        longitude,
        addressType,
        externalId,
        isValid,
        googlePlaceId,
      ];
}
