// https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty

import 'package:http/http.dart' show Client;
import 'package:http/http.dart' show Response;

import '../helper/check_connection.dart';
import '../models/hacker_news_comment_model.dart';

class HackerNewsCommentsServies {
  Client client = Client();
  ConnectionStatusSingleton connection =
      ConnectionStatusSingleton.getInstance();
  // List<String> comments = [];
  // List<int> commentKids;
  // HackerNewsCommentsServies(this.commentKids);

  Future<HackerNewsComment?> fetchCommentByKidNumber(int id) async {
    // ignore: avoid_print
    print("id>>> $id");
    if (!(await checkInternetConnection())) return null;
    final Uri uri =
        Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json');
    final Response response = await client.get(uri);
    if (response.statusCode != 200) return null;
    return HackerNewsComment.fromJson(response.body);
  }

  Future<bool> checkInternetConnection() {
    return connection.checkConnection();
  }
}
