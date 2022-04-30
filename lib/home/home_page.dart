import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimble_test_app/pharmacy/bloc/pharmacies_bloc.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacy.dart';
import 'package:nimble_test_app/pharmacy/model/pharmacy_medicines.dart';
import 'package:nimble_test_app/pharmacy/ui/pharmacy_details.dart';
import 'package:nimble_test_app/pharmacy/ui/shop_medicine.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle displayStyle = TextStyle(
        color: Colors.black54, fontSize: 20, fontWeight: FontWeight.normal);
    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Pharmacies",
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (state.pharamacyList != null)
                ? Container(
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: state.pharamacyList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              Pharmacy pharmacy = state.pharamacyList![index];
                              List<PharmacyMedicines> checkForItem = [];
                              if (state.pharamacyMedicinesList != null) {
                                checkForItem = state.pharamacyMedicinesList
                                    ?.where((element) =>
                                        element.pharmacyId ==
                                        pharmacy.pharmacyId)
                                    .toList() as List<PharmacyMedicines>;
                              }
                              bool isAddedAlready = checkForItem.isNotEmpty;
                              return Card(
                                child: ListTile(
                                    leading: isAddedAlready
                                        ? Icon(Icons.check_circle,
                                            size: 30, color: Colors.green)
                                        : null,
                                    title: Text('${pharmacy.name}',
                                        style: displayStyle),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                    ),
                                    onTap: () {
                                      BlocProvider.of<PharmaciesBloc>(context)
                                          .add(PharmacyDetailRequestEvent(
                                              pharmacyId:
                                                  pharmacy.pharmacyId!));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PharmacyDetailsPage(
                                                      pharmacy: pharmacy)));
                                    }),
                              );
                            }),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10.0),
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: () {
              BlocProvider.of<PharmaciesBloc>(context)
                  .add(MedicationListRequestEvent());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShopMedicine()));
            },
            child: const Text('Start order'),
          ),
        ),
      );
    });
  }
}
