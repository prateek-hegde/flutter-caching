import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_flux/flutter_flux.dart';
import 'package:sqflite_test/database/database.dart';
import 'package:sqflite_test/models/posts-model.dart';


class PostRepo {
  Future<Stream<Posts>> getPosts() async {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    var client = http.Client();
    var streamedRes = await client.send(http.Request('get', Uri.parse(url)));
    return streamedRes.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((body) => (body as List))
        .map((json) => Posts.fromJson(json));
  }
}

class PostsStore extends Store {
  final repo = PostRepo();
  PostsStore() {
    triggerOnAction(loadPostsAction, (nothing) async {
      List temp = await DBProvider.db.getAllPosts();
      if (temp.isNotEmpty) {
        print('data found');
        for (var i = 0; i < temp.length; i++) {
          _posts.add(temp[i]);
        }
      } else {
        var stream = await repo.getPosts();
        if (_posts.isEmpty) {
          stream.listen((post) {
            _posts.add(post);
            DBProvider.db.newPosts(post);
          });
        } else {
          _posts.clear();
          DBProvider.db.deleteAll();
          stream.listen((post) {
            _posts.add(post);
            DBProvider.db.newPosts(post);
          });
        }
      }
    });
  }

  final List<Posts> _posts = <Posts>[];
  List<Posts> get posts => List<Posts>.unmodifiable(_posts);
}

final Action loadPostsAction = Action();
final StoreToken postStoreToken = StoreToken(PostsStore());
