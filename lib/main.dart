import 'package:flutter/material.dart';
import 'package:sqflite_test/screens/home-screen.dart';
import 'package:sqflite_test/screens/splash-screen.dart';


void main() {
  runApp(MyApp());
}

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
};

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      title: 'SQFlite Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

