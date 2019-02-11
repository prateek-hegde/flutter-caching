import 'package:flutter/material.dart';
import 'package:sqflite_test/dataModel.dart';
import 'package:sqflite_test/store.dart';
import 'package:flutter_flux/flutter_flux.dart';

class TestScreen extends StatefulWidget {
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with StoreWatcherMixin<TestScreen> {
  PostsStore store;

  @override
  void initState() {
    super.initState();
    store = listenToStore(postStoreToken);
    // loadPostsAction.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFlite'),
      ),
      body: ListView(
          children: store.posts.map((post) => PostWidget(post)).toList()),
    );
  }
}

//store.posts.map((posts) => PostWidget(posts).toList());
class PostWidget extends StatelessWidget {
  PostWidget(this.post);
  final Posts post;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(post.id.toString()),
      title: Text(post.title),
    );
  }
}
