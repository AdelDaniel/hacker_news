// https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty

import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart' show Response;

import '../helper/check_connection.dart';
import '../models/hacker_news_story_model.dart';
import '../repositories/abstract_data_scource_caches.dart';

class HackerNewsStoryServies implements DataSource {
  Client client = Client();

  ConnectionStatusSingleton connection =
      ConnectionStatusSingleton.getInstance();
  List<int> ids = <int>[];

  @override
  Future<List<int>?> getTopStoriesIds() async {
    if (!(await checkInternetConnection())) return null;
    try {
      final Uri uri =
          Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json');
      final Response response = await client.get(uri);
      print(response.body);
      if (response.statusCode != 200) return null;
      ids = json.decode(response.body).cast<int>() as List<int>;
      print('ids From internet> $ids');
      return ids.cast<int>();
    } catch (e) {
      print(e);
      return [10];
    }
  }

// get story by id
  @override
  Future<HackerNewsStory?> fetchStoryById(int id) async {
    if (!(await checkInternetConnection())) return null;
    final Uri uri =
        Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json');
    final Response response = await client.get(uri);
    if (response.statusCode != 200) return null;
    return HackerNewsStory.fromJson(response.body);
  }

  Future<bool> checkInternetConnection() async {
    return await connection.checkConnection();
  }
}
