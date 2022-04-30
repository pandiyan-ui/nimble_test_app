import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:nimble_test_app/pharmacy_list/model/pharmacy.dart';

@immutable
class PharmaciesResponse extends Equatable {
  final List<Pharmacy>? pharmacies;
  final String? errorMessage;

  const PharmaciesResponse({this.pharmacies, this.errorMessage});

  Map<String, dynamic> toMap() {
    return {
      'pharmacies': pharmacies,
    };
  }

  factory PharmaciesResponse.fromMap(Map<String, dynamic> map) {
    return PharmaciesResponse(
      pharmacies: (map['pharmacies'] as List<dynamic>?)
              ?.map((dynamic i) => Pharmacy.fromMap(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PharmaciesResponse.fromJson(String source) =>
      PharmaciesResponse.fromMap(json.decode(source));

  factory PharmaciesResponse.fromException({String? errorMessage}) {
    return PharmaciesResponse(
        errorMessage: errorMessage ??
            "Something wrong at the moment. PLease try again later");
  }

  @override
  List<Object?> get props => [
        pharmacies,
        errorMessage,
      ];
}
