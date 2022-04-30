part of 'pharmacies_bloc.dart';

abstract class PharmaciesEvent extends Equatable {
  const PharmaciesEvent();

  @override
  List<Object> get props => [];
}

class PharmaciesRequestEvent extends PharmaciesEvent {
  const PharmaciesRequestEvent();

  @override
  List<Object> get props => [];
}

class PharmacyDetailRequestEvent extends PharmaciesEvent {
  final String pharmacyId;
  const PharmacyDetailRequestEvent({required this.pharmacyId});

  @override
  List<Object> get props => [pharmacyId];
}

class MedicationListRequestEvent extends PharmaciesEvent {
  const MedicationListRequestEvent();

  @override
  List<Object> get props => [];
}

class MapAddedMedicineToPharmacyEvent extends PharmaciesEvent {
  final List<String> medicinesAdded;
  final String pharmacyId;
  const MapAddedMedicineToPharmacyEvent({
    required this.medicinesAdded,
    required this.pharmacyId,
  });

  @override
  List<Object> get props => [medicinesAdded, pharmacyId];
}
