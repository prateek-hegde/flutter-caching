import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:sqflite_test/models/posts-model.dart';
import 'package:sqflite_test/stores/post-store.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with StoreWatcherMixin<HomeScreen> {
  PostsStore store;

  @override
  void initState() {
    super.initState();
    store = listenToStore(postStoreToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFlite App'),
      ),
      body: ListView(
          children: store.posts.map((post) => PostWidget(post)).toList()),
    );
  }
}

class PostWidget extends StatelessWidget {
  PostWidget(this.post);
  final Posts post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(post.id.toString()),
            title: Text(post.title),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
