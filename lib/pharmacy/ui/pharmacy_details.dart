import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimble_test_app/pharmacy/bloc/pharmacies_bloc.dart';
import 'package:nimble_test_app/pharmacy/model/address.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacy.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacy_medicines.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final Pharmacy pharmacy;
  const PharmacyDetailsPage({required this.pharmacy, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 25, fontWeight: FontWeight.w600);
    const TextStyle subTitleStyle = TextStyle(
        color: Colors.black87, fontSize: 25, fontWeight: FontWeight.normal);
    const TextStyle bodyStyle = TextStyle(
        color: Colors.black54, fontSize: 18, fontWeight: FontWeight.normal);
    Widget displayAddress(Address? address) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${address?.streetAddress1}', style: bodyStyle),
            Text('${address?.city}', style: bodyStyle),
            Text('${address?.usTerritory} - ${address?.postalCode}',
                style: bodyStyle),
          ]);
    }

    Widget displayHours(String? hoursString) {
      if (hoursString == null) {
        return SizedBox.shrink();
      }

      List<String> hoursList = hoursString.split("\\n");
      List<Widget> hoursListWidget = hoursList
          .map((hour) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(hour.trim(), style: bodyStyle),
              ))
          .toList();
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Wrap(
              children: [
                Icon(Icons.schedule, size: 30, color: Colors.blue),
                Text(
                  "Pharmacy hours:",
                  style: subTitleStyle,
                ),
              ],
            ),
            ...hoursListWidget
          ]);
    }

    Widget displayAddedMedicines(
        List<PharmacyMedicines>? pharamacyMedicinesList) {
      List<PharmacyMedicines> checkForItems = [];
      if (pharamacyMedicinesList != null) {
        checkForItems = pharamacyMedicinesList
            .where((element) => element.pharmacyId == pharmacy.pharmacyId)
            .toList();
      }
      if (checkForItems.isNotEmpty && checkForItems[0].medicinesAdded != null) {
        final medicinesList = checkForItems[0].medicinesAdded;
        if (medicinesList != null) {
          List<Widget> medicineListToDisplay = medicinesList
              .map((medicine) => Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(medicine, style: bodyStyle)))
              .toList();
          return Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  children: [
                    Icon(Icons.medication, size: 30, color: Colors.blue),
                    Text("Medicine Added List:", style: subTitleStyle),
                  ],
                ),
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
            "Pharmacy details",
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
                      Wrap(
                        children: [
                          Icon(Icons.place, size: 30, color: Colors.blue),
                          Text('${state.pharmacyDetail?.name}',
                              style: titleStyle),
                        ],
                      ),
                      displayAddress(state.pharmacyDetail?.address),
                      if (state.pharmacyDetail?.primaryPhoneNumber != null)
                        SizedBox(height: 20),
                      if (state.pharmacyDetail?.primaryPhoneNumber != null)
                        Wrap(
                          children: [
                            Icon(Icons.phone, size: 30, color: Colors.blue),
                            Text(
                              '${state.pharmacyDetail?.primaryPhoneNumber}',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
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
