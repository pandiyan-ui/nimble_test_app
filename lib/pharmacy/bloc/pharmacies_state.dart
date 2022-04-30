part of 'pharmacies_bloc.dart';

abstract class PharmaciesState extends Equatable {
  final List<Pharmacy>? pharamacyList;
  final PharmacyDetails? pharmacyDetail;
  final List<String>? medicines;
  final List<PharmacyMedicines>? pharamacyMedicinesList;

  const PharmaciesState({
    this.pharamacyList,
    this.pharmacyDetail,
    this.pharamacyMedicinesList,
    this.medicines,
  });

  @override
  List<Object> get props => [];
}

class PharmaciesInitialState extends PharmaciesState {}

class LocalCopyPharmacyState extends PharmaciesState {
  LocalCopyPharmacyState(
    PharmaciesState state, {
    PharmacyDetails? pharmacyDetail,
    List<Pharmacy>? pharamacyList,
    List<PharmacyMedicines>? pharamacyMedicinesList,
    List<String>? medicines,
  }) : super(
          pharamacyList: pharamacyList ?? state.pharamacyList,
          pharmacyDetail: pharmacyDetail ?? state.pharmacyDetail,
          pharamacyMedicinesList:
              pharamacyMedicinesList ?? state.pharamacyMedicinesList,
          medicines: medicines ?? state.medicines,
        );
}

class PharmaciesListFailureState extends PharmaciesState {
  final String message;
  PharmaciesListFailureState({required this.message});
}

class PharmaciesUnlikeState extends PharmaciesState {
  PharmaciesUnlikeState(state)
      : super(
          pharamacyList: state.pharamacyList,
          pharmacyDetail: null,
          pharamacyMedicinesList: state.pharamacyMedicinesList,
          medicines: state.medicines,
        );
}
