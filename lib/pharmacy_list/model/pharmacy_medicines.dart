import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class PharmacyMedicines extends Equatable {
  final String? pharmacyId;
  final String? name;
  final List<String>? medicinesAdded;

  const PharmacyMedicines({
    this.pharmacyId,
    this.name,
    this.medicinesAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'pharmacyId': pharmacyId,
      'name': name,
      'medicinesAdded': medicinesAdded,
    };
  }

  factory PharmacyMedicines.fromMap(Map<String, dynamic> map) {
    return PharmacyMedicines(
      pharmacyId: map['pharmacyId'] != null ? map['pharmacyId'] : null,
      name: map['name'] != null ? map['name'] : null,
      medicinesAdded:
          map['medicinesAdded'] != null ? map['medicinesAdded'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PharmacyMedicines.fromJson(String source) =>
      PharmacyMedicines.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        pharmacyId,
        name,
        medicinesAdded,
      ];

  PharmacyMedicines copyWith({
    String? pharmacyId,
    String? name,
    List<String>? medicinesAdded,
  }) {
    return PharmacyMedicines(
      pharmacyId: pharmacyId ?? this.pharmacyId,
      name: name ?? this.name,
      medicinesAdded: medicinesAdded ?? this.medicinesAdded,
    );
  }
}
