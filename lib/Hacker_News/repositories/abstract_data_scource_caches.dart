import '../models/hacker_news_story_model.dart';

abstract class DataSource {
  Future<HackerNewsStory?> fetchStoryById(int id);
  Future<List<int>?> getTopStoriesIds();
  // By default, == returns true if two objects are the same instance.

}

abstract class Cache {
  Future<bool> addItem(HackerNewsStory item);
  Future<int> clearCache();
}
