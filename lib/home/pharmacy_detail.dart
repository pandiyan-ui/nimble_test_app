import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimble_test_app/pharmacy_list/bloc/pharmacies_bloc.dart';
import 'package:nimble_test_app/pharmacy_list/model/address.dart';
import 'package:nimble_test_app/pharmacy_list/model/pharmacy.dart';
import 'package:nimble_test_app/pharmacy_list/model/pharmacy_medicines.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final Pharmacy pharmacy;
  const PharmacyDetailsPage({required this.pharmacy, Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
     const TextStyle displayStyle = TextStyle(
          color: Colors.black54, fontSize: 20, fontWeight: FontWeight.normal);
    Widget displayAddress(Address? address) {
      
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${address?.streetAddress1}', style: displayStyle),
            Text('${address?.city}', style: displayStyle),
            Text('${address?.usTerritory} - ${address?.postalCode}',
                style: displayStyle),
          ]);
    }

    Widget displayHours(String? hoursString) {
      if (hoursString == null) {
        return SizedBox.shrink();
      }
  
      List<String> hoursList = hoursString.split("\\n");
      List<Widget> hoursListWidget =
          hoursList.map((hour) => Padding(
            padding: const EdgeInsets.only(top:8 ),
            child: Text(hour.trim(), style: displayStyle),
          ) ).toList();
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Pharmacy hours:",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.normal),
            ),
            ...hoursListWidget
          ]);
    }

    Widget displayAddedMedicines(
        List<PharmacyMedicines>? pharamacyMedicinesList) {
      const TextStyle style = TextStyle(
          color: Colors.black87, fontSize: 25, fontWeight: FontWeight.normal);
      List<PharmacyMedicines> checkForItems = [];
      if (pharamacyMedicinesList != null) {
        checkForItems = pharamacyMedicinesList
            .where((element) => element.pharmacyId == pharmacy.pharmacyId)
            .toList();
      }
      if (checkForItems.length> 0 && checkForItems[0].medicinesAdded != null) {
        final medicinesList = checkForItems[0].medicinesAdded;
        if (medicinesList != null) {
          List<Widget> medicineListToDisplay = medicinesList.map((medicine) => Padding(padding: EdgeInsets.only(bottom:8),
          child: SizedBox(height:20, child: Text(medicine, style: displayStyle)))).toList();
          return Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Medicine Added List:", style: style),
                SizedBox(height: 8),
                ...medicineListToDisplay,
              ],
            ),
          );
        }
         return SizedBox();
      }
      return SizedBox();
    }

    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Pharmacy detail",
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: (state.pharmacyDetail != null)
              ? Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.pharmacyDetail?.name}',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 38,
                              fontWeight: FontWeight.w600)),
                      displayAddress(state.pharmacyDetail?.address),
                      if (state.pharmacyDetail?.primaryPhoneNumber != null)
                        SizedBox(height: 20),
                      if (state.pharmacyDetail?.primaryPhoneNumber != null)
                        Text(
                          '${state.pharmacyDetail?.primaryPhoneNumber}',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                      displayHours(state.pharmacyDetail?.pharmacyHours),
                      if (state.pharamacyMedicinesList != null)
                        displayAddedMedicines(state.pharamacyMedicinesList),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Center(child: CircularProgressIndicator())),
                  ],
                ),
        ),
      );
    });
  }
}
