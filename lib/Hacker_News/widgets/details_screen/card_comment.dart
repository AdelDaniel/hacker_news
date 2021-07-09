import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/hacker_news_comment_model.dart';

class CardComment extends StatelessWidget {
  CardComment(
      {Key? key, required this.comment, required this.streamSnapShotData})
      : super(key: key);
  final HackerNewsComment comment;
  final Map<int, Future<HackerNewsComment?>> streamSnapShotData;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        onTap: comment.kids.isEmpty
            ? null
            : () {
                _controller.add(true);
              },
        title: Text(comment.by),
        subtitle: Column(
          children: <Widget>[
            buildText(comment.text),
            Text(
                "\n\n ↩️ ${comment.kids.isEmpty ? "no comments" : comment.kids.length} "),

            // StreamBuilder<bool>(
            //   stream: _controller.stream,
            //   builder: (buildContext, AsyncSnapshot<bool> asyncIsTrue) {
            //     print(asyncIsTrue.data);
            //     if (asyncIsTrue.hasData) {
            //       if (asyncIsTrue.data!) {
            //         print('data is Ture');
            //         CommentsBloc _bloc = CommentsProvider.of(context)!;
            //         List<Widget> children = [];
            //         comment.kids.forEach((kidId) {
            //           _bloc.fetchComment(kidId);
            //           StreamBuilder(
            //             stream: _bloc.fetchcommentStream,
            //             builder: (b, a) {
            //               if (a.hasData) {
            //                 children.add(GetSingleComment(
            //                     streamSnapShotData: streamSnapShotData,
            //                     commentId: kidId));
            //                 return SizedBox();
            //               }
            //               return SizedBox();
            //             },
            //           );
            //         });
            //         return Column(children: children);
            //         // List<Widget> children = [];
            //         // comment.kids.forEach((kidId) {
            //         //   print(kidId);
            //         //   children.add(GetSingleComment(
            //         //       streamSnapShotData: streamSnapShotData,
            //         //       commentId: kidId));
            //         // });
            //         // print(children);
            //         // return Column(children: children);

            //         // return GetSingleComment(
            //         //     streamSnapShotData: streamSnapShotData,
            //         //     commentId: comment.kids[0]);

            //         // return Container(
            //         //   color: Colors.amber,
            //         //   height: 10,
            //         //   width: 10,
            //         // );
            //       } else {
            //         return SizedBox();
            //       }
            //     } else {
            //       return SizedBox();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) => Html(data: text);

  void dispose() {
    _controller.close();
  }
}
