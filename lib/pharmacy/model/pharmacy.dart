import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Pharmacy extends Equatable {
  final String? pharmacyId;
  final String? name;
  final bool? isOrderPlaced;

  const Pharmacy({this.pharmacyId, this.name, this.isOrderPlaced});

  Map<String, dynamic> toMap() {
    return {
      'pharmacyId': pharmacyId,
      'name': name,
      'isOrderPlaced': isOrderPlaced,
    };
  }

  factory Pharmacy.fromMap(Map<String, dynamic> map) {
    return Pharmacy(
      pharmacyId: map['pharmacyId'] != null ? map['pharmacyId'] : null,
      name: map['name'] != null ? map['name'] : null,
      isOrderPlaced: map['isOrderPlaced'] != null ? map['isOrderPlaced'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pharmacy.fromJson(String source) =>
      Pharmacy.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        pharmacyId,
        name,
        isOrderPlaced,
      ];

  Pharmacy copyWith({
    String? pharmacyId,
    String? name,
    bool? isOrderPlaced,
  }) {
    return Pharmacy(
      pharmacyId: pharmacyId ?? this.pharmacyId,
      name: name ?? this.name,
      isOrderPlaced: isOrderPlaced ?? this.isOrderPlaced,
    );
  }
}
