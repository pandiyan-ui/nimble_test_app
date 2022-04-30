import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:nimble_test_app/home/pharmacy_detail.dart';
import 'package:nimble_test_app/pharmacy_list/model/pharmacy_details.dart';
import 'package:nimble_test_app/pharmacy_list/model/seed_response.dart';

class PharmaciesDataProvider {
  Future<PharmaciesResponse> fetchPharmaciesData() async {
    // commented out the real http call since I dont have a end-point for now

    // final response = await http
    //     .get(Uri.parse('https://sample-end-point/qrcode/seed'));

    // if (response.statusCode == 200) {
    //   return SeedResponse.fromJson(response.body);
    // } else {
    //   return SeedResponse.fromException();
    // }
    final mockResponse =
        getMockSeedResponse(); // using the mock data for dev purpose
    return PharmaciesResponse.fromMap(mockResponse);
  }

  Map<String, dynamic> getMockSeedResponse() {
    Map<String, dynamic> mockResponse = {
      "pharmacies": [
        {"name": "ReCept", "pharmacyId": "NRxPh-HLRS"},
        {"name": "My Community Pharmacy", "pharmacyId": "NRxPh-BAC1"},
        {"name": "MedTime Pharmacy", "pharmacyId": "NRxPh-SJC1"},
        {"name": "NY Pharmacy", "pharmacyId": "NRxPh-ZEREiaYq"}
      ]
    };

    return mockResponse;
  }

  Future<PharmacyDetails> fetchPharmacyDetailsData(pharmacyId) async { //fetchMedicationListData
    //commented out the real http call since I dont have a end-point for now

    final response = await http.get(Uri.parse(
        'https://api-qa-demo.nimbleandsimple.com/pharmacies/info/$pharmacyId'));


  final responseX = await http.get(Uri.parse(
        'https://s3-us-west-2.amazonaws.com/assets.nimblerx.com/prod/medicationListFromNIH/medicationListFromNIH.txt'));



    if (response.statusCode == 200) {
      return PharmacyDetails.fromJson(response.body);
      //return PharmacyDetails.fromMap(response as Map<String, dynamic>);
    } else {
      return PharmacyDetails.fromMap(response as Map<String, dynamic>);
    }
  }

  
  Future<String> fetchMedicationListData() async { 
    //commented out the real http call since I dont have a end-point for now


  final response = await http.get(Uri.parse(
        'https://s3-us-west-2.amazonaws.com/assets.nimblerx.com/prod/medicationListFromNIH/medicationListFromNIH.txt'));

    if (response.statusCode == 200) {
      return response.body;
      //return PharmacyDetails.fromMap(response as Map<String, dynamic>);
    } else {
      return "Error";
    }
  }
}
