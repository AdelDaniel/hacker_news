import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../models/hacker_news_comment_model.dart';
import '../../repositories/hacker_news_comment_repo.dart';

class CommentsBloc {
  final PublishSubject<int> _fetchCommentsPublishSubject =
      PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<HackerNewsComment?>>>
      _outputCommentsBehaviorSubject =
      BehaviorSubject<Map<int, Future<HackerNewsComment?>>>();

  final HackerNewscommentRepository _hackerNewscommentRepository =
      HackerNewscommentRepository();

  CommentsBloc() {
    _fetchCommentsPublishSubject
        .transform<Map<int, Future<HackerNewsComment?>>>(_commentsTransformer())
        .pipe(_outputCommentsBehaviorSubject);
  }

  ScanStreamTransformer<int, Map<int, Future<HackerNewsComment?>>>
      _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<HackerNewsComment?>>>(
        (Map<int, Future<HackerNewsComment?>> cache, int commentId, int index) {
      // ignore: avoid_print
      print(index);
      cache[commentId] = _hackerNewscommentRepository.getcomment(commentId);
      return cache;
    }, <int, Future<HackerNewsComment?>>{});
  }

  // getting the sink methods
  Function(int) get fetchComment => _fetchCommentsPublishSubject.sink.add;
  // Function(HackerNewsComment) get outputComment =>
  //     _outputCommentsBehaviorSubject.sink.add;

  //getting the streams
  Stream<int> get fetchcommentStream => _fetchCommentsPublishSubject.stream;
  Stream<Map<int, Future<HackerNewsComment?>>> get outputStream =>
      _outputCommentsBehaviorSubject.stream;

  void dispose() {
    _fetchCommentsPublishSubject.close();
    _outputCommentsBehaviorSubject.close();
  }
}
