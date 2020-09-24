import 'package:flutter/foundation.dart';
import 'package:nextflow_personal_post/database/post_db.dart';
import 'package:nextflow_personal_post/database/post_db_sqflite.dart';
import 'package:nextflow_personal_post/models/post_model.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  PostDBSqflite _postDB;

  // List<String> get posts {
  //   return _posts;
  // }
  List<Post> get posts => _posts;

  PostProvider() {
    _postDB = PostDBSqflite(databaseName: 'app.db');
  }

  addNewPost(String postMessage) async {
    var post = Post(message: postMessage, createdDate: DateTime.now());

    await _postDB.save(post);
    var postsFromDB = await _postDB.loadAllPosts();

    _posts = postsFromDB;

    notifyListeners();
  }

  initData() async {
    _posts = await _postDB.loadAllPosts();
    notifyListeners();
  }

  clearAllPost() async {
    await _postDB.clearPostData();

    _posts = [];

    notifyListeners();
  }
}
