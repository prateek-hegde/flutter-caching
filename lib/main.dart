import 'package:flutter/material.dart';
import 'package:sqflite_test/splash.dart';
import 'package:sqflite_test/test-screen.dart';

void main() {
  runApp(MyApp());
}

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => TestScreen(),
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
      title: 'Caching Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.blueAccent,
      ),
      home: SplashScreen(),
    );
  }
}

