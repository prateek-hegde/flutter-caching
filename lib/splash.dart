import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite_test/store.dart';
import 'package:flutter_flux/flutter_flux.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>
    with StoreWatcherMixin<SplashScreen> {
  PostsStore store;
  @override
  void initState() {
    store = listenToStore(postStoreToken);
    loadPostsAction.call();

    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, "/home"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('LOGO'),
        ));
  }
}
