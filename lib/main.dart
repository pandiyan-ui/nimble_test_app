import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimble_test_app/home/splash_screen.dart';
import 'package:nimble_test_app/pharmacy/bloc/pharmacies_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PharmaciesBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nimble test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.white,
          ),
          home: SplashScreen(),
        ));
  }
}
