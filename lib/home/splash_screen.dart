import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimble_test_app/home/home_page.dart';
import 'package:nimble_test_app/pharmacy/bloc/pharmacies_bloc.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PharmaciesBloc>(context)
        .add(const PharmaciesRequestEvent());
    Timer(
        Duration(milliseconds: 2000),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(0xFF4174FE),
                radius: 100,
                child: Icon(Icons.local_pharmacy_outlined,
                    color: Colors.white, size: 100),
              ),
              SizedBox(height: 30),
              Text("Pharmacy test",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xFF4174FE),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
