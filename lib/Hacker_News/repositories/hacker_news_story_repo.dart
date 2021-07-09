import '../helper/db__hacker_news_helper.dart';
import '../models/hacker_news_story_model.dart';
import '../repositories/abstract_data_scource_caches.dart';
import '../services/hacker_news_story_service.dart';

class HackerNewsStoryRepository {
  final List<DataSource> _sources = <DataSource>[
    HackerNewsStoryServies(),
    HackerNewsDb()
  ];
  final List<Cache> _caches = <Cache>[HackerNewsDb()];

  Future<List<int>?> getTopIds() async {
    DataSource source;
    late List<int>? topIds;
    for (source in _sources) {
      topIds = await source.getTopStoriesIds();
      if (topIds != null) {
        // print('data null $topIds');
        break;
      }
    }
    return topIds;
    // return _sources[0].getTopStoriesIds();
  }

  Future<HackerNewsStory?> getItem(int id) async {
    HackerNewsStory? hackerNewsStory;
    late DataSource source;

    for (source in _sources) {
      hackerNewsStory = await source.fetchStoryById(id);
      if (hackerNewsStory != null) {
        break;
      }
    }
    if (hackerNewsStory != null) {
      for (final Cache cache in _caches) {
        if (!identical(source, cache)) await cache.addItem(hackerNewsStory);
        // print("identical");
        // print(identical(source, cache));
      }
    }
    return hackerNewsStory;
  }

  Future<int> clearCache() async {
    int value = 0;
    for (final Cache cache in _caches) {
      value = await cache.clearCache();
    }
    return value;
  }
}
