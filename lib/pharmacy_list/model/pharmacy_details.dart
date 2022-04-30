import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nimble_test_app/pharmacy_list/model/address.dart';

@immutable
class PharmacyDetails extends Equatable {
  final String? pharmacyId;
  final String? name;
  final String? primaryPhoneNumber;
  final String? pharmacyHours;
  final Address? address;

  const PharmacyDetails({
    this.pharmacyId,
    this.name,
    this.primaryPhoneNumber,
    this.pharmacyHours,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'pharmacyId': pharmacyId,
      'name': name,
      'primaryPhoneNumber': primaryPhoneNumber,
      'pharmacyHours': pharmacyHours,
    };
  }

  factory PharmacyDetails.fromMap(Map<String, dynamic> mapped) {
    final Map<String, dynamic> map = mapped['value'];
    return PharmacyDetails(
      pharmacyId: map['pharmacyId'] != null ? map['pharmacyId'] : null,
      name: map['name'] != null ? map['name'] : null,
      primaryPhoneNumber:
          map['primaryPhoneNumber'] != null ? map['primaryPhoneNumber'] : null,
      pharmacyHours: map['pharmacyHours'] != null ? map['pharmacyHours'] : null,
      address: map['address'] != null
          ? Address.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PharmacyDetails.fromJson(String source) =>
      PharmacyDetails.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        pharmacyId,
        name,
        primaryPhoneNumber,
        pharmacyHours,
        address,
      ];
}
