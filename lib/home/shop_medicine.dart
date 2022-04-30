import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimble_test_app/home/dashboard_page.dart';
import 'package:nimble_test_app/pharmacy_list/bloc/pharmacies_bloc.dart';

class ShopMedicine extends StatefulWidget {
  ShopMedicine({Key? key}) : super(key: key);

  @override
  _ShopMedicineState createState() => _ShopMedicineState();
}

class _ShopMedicineState extends State<ShopMedicine> {
  final List<String> cartItems = [];
  List<bool> selected = [];

  Icon addIcon = Icon(
    Icons.add,
    color: Colors.blueAccent,
    size: 35,
  );
  Icon removeIcon = Icon(
    Icons.delete,
    color: Colors.red,
    size: 35,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state) {
      if (state.medicines != null) {
        for (int i = 0; i < state.medicines!.length; i++) {
          selected.add(false);
        }
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Shop medicines",
            textAlign: TextAlign.center,
          ),
        ),
        body: state.medicines != null
            ? ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: state.medicines?.length,
                itemBuilder: (BuildContext context, int index) {
                  String medicine = state.medicines![index];
                  return Card(
                    child: ListTile(
                      title: Text(medicine),
                      trailing: IconButton(
                        icon: selected.elementAt(index) ? removeIcon : addIcon,
                        onPressed: () {
                          setState(() {
                            selected[index] = !selected.elementAt(index);
                          });
                          if (cartItems.contains(medicine)) {
                            cartItems.remove(medicine);
                          } else {
                            cartItems.add(medicine);
                          }
                        },
                      ),
                    ),
                  );
                })
            : SizedBox(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: () {
              BlocProvider.of<PharmaciesBloc>(context)
                  .add(MapAddedMedicineToPharmacyEvent(
                pharmacyId: "NRxPh-HLRS",
                medicinesAdded: cartItems,
              ));

               Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
            },
            child: const Text('Confirm order'),
          ),
        ),
      );
    });
  }
}
