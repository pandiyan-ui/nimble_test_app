import 'package:nimble_test_app/pharmacy_list/model/pharmacy_details.dart';
import 'package:nimble_test_app/pharmacy_list/model/seed_response.dart';
import 'package:nimble_test_app/pharmacy_list/repo/pharmacies_data_provider.dart';

class PharmaciesRepository {
  final PharmaciesDataProvider _pharmaciesDataProvider;
  PharmaciesRepository({PharmaciesDataProvider? pharmaciesDataProvider})
      : _pharmaciesDataProvider =
            pharmaciesDataProvider ?? PharmaciesDataProvider();

  Future<PharmaciesResponse> fetchPharmaciesData() {
    return _pharmaciesDataProvider.fetchPharmaciesData();
  }

  Future<PharmacyDetails> fetchPharmacyDetailsData(String pharmacyId) {
    return _pharmaciesDataProvider.fetchPharmacyDetailsData(pharmacyId);
  }

  Future<String> fetchMedicationListData() {
    return _pharmaciesDataProvider.fetchMedicationListData();
  }
}
