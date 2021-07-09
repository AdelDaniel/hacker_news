import '../models/hacker_news_comment_model.dart';
import '../services/hacker_news_comments_service.dart';

class HackerNewscommentRepository {
  final HackerNewsCommentsServies _hackerNewsCommentsServies =
      HackerNewsCommentsServies();

  Future<HackerNewsComment?> getcomment(int id) {
    return _hackerNewsCommentsServies.fetchCommentByKidNumber(id);
  }
}
