import 'package:nextflow_personal_post/models/post_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class PostDBSqflite {
  String databaseName;

  PostDBSqflite({this.databaseName});

  Future<sqflite.Database> openDatabase() async {
    var appDocumentDirectory = await getApplicationDocumentsDirectory();
    var databaseLocationInApp =
        join(appDocumentDirectory.path, this.databaseName);

    var database = await sqflite.openDatabase(
      databaseLocationInApp,
      version: 1,
      onCreate: (db, version) async {
        var sql =
            "CREATE TABLE IF NOT EXISTS Posts (id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT, createdDate DATETIME)";
        await db.execute(sql);
      },
    );
    return database;
  }

  Future<int> save(Post post) async {
    var database = await this.openDatabase();
    var sql = "INSERT INTO Posts (message, createdDate) VALUES (?,?)";

    var dataId = database
        .rawInsert(sql, [post.message, post.createdDate.toIso8601String()]);
    return dataId;
  }

  Future<List<Post>> loadAllPosts() async {
    var database = await this.openDatabase();
    var sql = "SELECT * FROM Posts ORDER BY id DESC";

    var results = await database.rawQuery(sql);

    var postsList = List<Post>();

    for (var dataItem in results) {
      var dataMessage = dataItem['message'];
      var dataCreatedDate = DateTime.tryParse(dataItem['createdDate']);
      var post = Post(
        message: dataMessage,
        createdDate: dataCreatedDate,
      );
      postsList.add(post);
    }

    return postsList;
  }

  Future<void> clearPostData() async {
    var database = await this.openDatabase();
    var sql = "DELETE FROM Posts";
    await database.execute(sql);
  }
}
