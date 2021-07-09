import 'package:rxdart/rxdart.dart';

import '../../models/hacker_news_story_model.dart';
import '../../repositories/hacker_news_story_repo.dart';

class StoriesBloc {
  final PublishSubject<List<int>> _topIdsSubject = PublishSubject<List<int>>();
  final BehaviorSubject<int> _behaviorSubject = BehaviorSubject<int>();
  final PublishSubject<int> _itemFetcher = PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<HackerNewsStory?>>> _itemOutput =
      BehaviorSubject<Map<int, Future<HackerNewsStory?>>>();

  final HackerNewsStoryRepository _repository = HackerNewsStoryRepository();

  StoriesBloc() {
    _itemFetcher.stream.transform(_itemTransformer()).pipe(_itemOutput);
  }
  ScanStreamTransformer<int, Map<int, Future<HackerNewsStory?>>>
      _itemTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<HackerNewsStory?>>>(
      (Map<int, Future<HackerNewsStory?>> cache, int id, int index) {
        // ignore: avoid_print
        print(index);
        cache[id] = _repository.getItem(id);
        return cache;
      },
      <int, Future<HackerNewsStory?>>{},
    );
  }

  // getter to the Streams
  Stream<List<int>> get topIdsStream => _topIdsSubject.stream;

  Stream<Map<int, Future<HackerNewsStory?>>> get itemOutput =>
      _itemOutput.stream;

  //getters to sinks (add data to controller)
  Function(int) get fetchItem => _itemFetcher.sink.add;

  //methods that calls the repo methods to do tasks
  Future<void> fetchTopIds() async {
    // ignore: avoid_print
    print('Start fetching');
    final List<int>? _topIds = await _repository.getTopIds();
    if (_topIds != null) _topIdsSubject.sink.add(_topIds);
    print(_topIds);
  }

  Future<int> clearCache() {
    return _repository.clearCache();
  }

  void dispose() {
    _behaviorSubject.close();
    _topIdsSubject.close();
    _itemOutput.close();
    _itemFetcher.close();
  }
}
