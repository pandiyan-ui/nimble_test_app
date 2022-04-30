import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimble_test_app/pharmacy/bloc/pharmacies_bloc.dart';
import 'package:nimble_test_app/pharmacy/ui/success_view.dart';

class ShopMedicine extends StatefulWidget {
  ShopMedicine({Key? key}) : super(key: key);

  @override
  _ShopMedicineState createState() => _ShopMedicineState();
}

class _ShopMedicineState extends State<ShopMedicine> {
  final List<String> cartItems = [];
  List<bool> itemSelected = [];

  Icon addIcon = Icon(
    Icons.add_circle_outline_outlined,
    color: Colors.blueAccent,
    size: 35,
  );
  Icon removeIcon = Icon(
    Icons.cancel,
    color: Colors.red,
    size: 35,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state) {
      if (state.medicines != null) {
        for (int i = 0; i < state.medicines!.length; i++) {
          itemSelected.add(false);
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
                      trailing: Semantics(
                        enabled: true,
                        label: itemSelected.elementAt(index)
                            ? "tap to remove"
                            : "tap to add",
                        child: IconButton(
                          tooltip:
                              itemSelected.elementAt(index) ? "remove" : "add",
                          icon: itemSelected.elementAt(index)
                              ? removeIcon
                              : addIcon,
                          onPressed: () {
                            setState(() {
                              itemSelected[index] =
                                  !itemSelected.elementAt(index);
                            });
                            if (cartItems.contains(medicine)) {
                              cartItems.remove(medicine);
                            } else {
                              cartItems.add(medicine);
                            }
                          },
                        ),
                      ),
                    ),
                  );
                })
            : SizedBox(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
          child: Semantics(
            enabled: cartItems.isNotEmpty,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: cartItems.isNotEmpty
                  ? () {
                      BlocProvider.of<PharmaciesBloc>(context)
                          .add(MapAddedMedicineToPharmacyEvent(
                        pharmacyId: "NRxPh-HLRS",
                        medicinesAdded: cartItems,
                      ));
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext bc) {
                            return Container(
                              color: Colors.white,
                              child: SuccessView(),
                            );
                          });
                      Future.delayed(Duration(milliseconds: 2000), () {
                        Navigator.popUntil(
                            context, (Route<dynamic> route) => route.isFirst);
                      });
                    }
                  : null,
              child: const Text('Confirm order'),
            ),
          ),
        ),
      );
    });
  }
}
