import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacies_response.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacy.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacy_details.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacy_medicines.dart';
import 'package:nimble_test_app/pharmacy/repo/pharmacies_repo.dart';

part 'pharmacies_event.dart';
part 'pharmacies_state.dart';

class PharmaciesBloc extends Bloc<PharmaciesEvent, PharmaciesState> {
  final PharmaciesRepository _pharmaciesRepository;

  PharmaciesBloc({PharmaciesRepository? pharmaciesRepository})
      : _pharmaciesRepository = pharmaciesRepository ?? PharmaciesRepository(),
        super(PharmaciesInitialState()) {
    on<PharmaciesRequestEvent>(_pharmaciesRequestEventHandler);
    on<PharmacyDetailRequestEvent>(_pharmacyDetailRequestEvent);
    on<MedicationListRequestEvent>(_medicationListRequestEvent);
    //
    on<MapAddedMedicineToPharmacyEvent>(_mapAddedMedicineToPharmacyEvent);
  }

  Future<void> _pharmaciesRequestEventHandler(
      PharmaciesRequestEvent event, Emitter<PharmaciesState> emit) async {
    try {
      PharmaciesResponse response =
          await _pharmaciesRepository.fetchPharmaciesData();
      // yield the successful state stream
      emit(LocalCopyPharmacyState(
        state,
        pharamacyList: response.pharmacies ?? [],
      ));
    } catch (e) {
      // yield the unsuccessful state stream
      emit(PharmaciesListFailureState(
          message: "Error happened try again later"));
    }
  }

  Future<void> _pharmacyDetailRequestEvent(
      PharmacyDetailRequestEvent event, Emitter<PharmaciesState> emit) async {
    emit(PharmaciesUnlikeState(state));
    try {
      PharmacyDetails response = await _pharmaciesRepository
          .fetchPharmacyDetailsData(event.pharmacyId);
      // emit the successful state
      emit(LocalCopyPharmacyState(state, pharmacyDetail: response));
    } catch (e) {
      // emit the unsuccessful state stream
      emit(
        PharmaciesListFailureState(message: "Error happened try again later"),
      );
    }
  }

  Future<void> _medicationListRequestEvent(
      MedicationListRequestEvent event, Emitter<PharmaciesState> emit) async {
    emit(PharmaciesUnlikeState(state));
    try {
      String response = await _pharmaciesRepository.fetchMedicationListData();
      // emit the successful state stream

      emit(LocalCopyPharmacyState(state, medicines: response.split(",\n")));
    } catch (e) {
      // emit the unsuccessful state stream
      emit(PharmaciesListFailureState(
          message: "Error happened try again later"));
    }
  }

  Future<void> _mapAddedMedicineToPharmacyEvent(
      MapAddedMedicineToPharmacyEvent event,
      Emitter<PharmaciesState> emit) async {
    emit(PharmaciesUnlikeState(state));

    final PharmacyMedicines currentItem = PharmacyMedicines(
      medicinesAdded: event.medicinesAdded,
      pharmacyId: event.pharmacyId,
    );

    // List<PharmacyMedicines>? itemToAdd = [];
    // if (state.pharamacyMedicinesList == null) {
    //   itemToAdd = [currentItem];
    // } else {
    //   state.pharamacyMedicinesList?.add(currentItem);
    //   itemToAdd = state.pharamacyMedicinesList;
    // }

    emit(LocalCopyPharmacyState(
      state,
      pharamacyMedicinesList: [currentItem],
    ));
  }
}
