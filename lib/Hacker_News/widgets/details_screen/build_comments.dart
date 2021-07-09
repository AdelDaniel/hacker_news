import 'dart:async';

import 'package:flutter/material.dart';

import '../../bloc_using_inherited_widgets/comments_bloc/comments_provider.dart';
import '../../models/hacker_news_comment_model.dart';
import '../loading_container.dart';
import 'comment.dart';

class BuildComments extends StatelessWidget {
  const BuildComments({Key? key, required this.storyKids}) : super(key: key);
  final List<int> storyKids;

  @override
  Widget build(BuildContext context) {
    final CommentsBloc _commentsBloc = CommentsProvider.of(context)!;
    // print("id>>");
    // print(storyKids);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: storyKids.length,
      itemBuilder: (BuildContext buildContext, int index) {
        _commentsBloc.fetchComment(storyKids[index]);
        return getComments(
            commentId: storyKids[index], commentsBloc: _commentsBloc);
      },
    );
  }

  Widget getComments(
      {required int commentId, required CommentsBloc commentsBloc}) {
    return StreamBuilder<Map<int, Future<HackerNewsComment?>>>(
      stream: commentsBloc.outputStream,
      builder: (BuildContext buildcontext,
          AsyncSnapshot<Map<int, Future<HackerNewsComment?>>> streamSnapShot) {
        if (streamSnapShot.connectionState == ConnectionState.waiting) {
          return const LoadingContainer();
        }
        if (!streamSnapShot.hasData) return const SizedBox();
        return GetSingleComment(
            streamSnapShotData: streamSnapShot.data!, commentId: commentId);
      },
    );
  }
}
