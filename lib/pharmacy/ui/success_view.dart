import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatefulWidget {
  SuccessView({Key? key}) : super(key: key);
  @override
  _SuccessViewState createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  late Size dSize;
  late MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    dSize = mediaQuery.size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: dSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 100,
                        child: Icon(Icons.done_outlined,
                            color: Colors.white, size: 100),
                      ),
                      SizedBox(height: 30),
                      Text("Successfully ordered!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.green,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
              bottomRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}
