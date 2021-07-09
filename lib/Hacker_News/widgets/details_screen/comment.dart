import 'package:flutter/material.dart';

import '../../models/hacker_news_comment_model.dart';
import '../loading_container.dart';
import 'card_comment.dart';

class GetSingleComment extends StatelessWidget {
  final Map<int, Future<HackerNewsComment?>> streamSnapShotData;
  final int commentId;
  const GetSingleComment(
      {Key? key, required this.streamSnapShotData, required this.commentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print("getting Comments :: ");
    return FutureBuilder<HackerNewsComment?>(
      future: streamSnapShotData[commentId],
      builder: (BuildContext buildcontext,
          AsyncSnapshot<HackerNewsComment?> itemSnapShot) {
        print(itemSnapShot.connectionState);
        if (itemSnapShot.connectionState == ConnectionState.waiting) {
          return const LoadingContainer();
        }
        if (!itemSnapShot.hasData) return const SizedBox();
        // ignore: avoid_print
        print("getting Comments");
        return CardComment(
            comment: itemSnapShot.data!,
            streamSnapShotData: streamSnapShotData);
      },
    );
  }
}



// import 'package:a5barry/Hacker_News/models/hacker_news_comment_model.dart';
// import 'package:a5barry/Hacker_News/widgets/details_screen/card_comment.dart';
// import 'package:flutter/material.dart';

// import '../loading_container.dart';

// class Comment extends StatelessWidget {
//   const Comment(
//       {Key? key,
//       required this.itemId,
//       required this.commentMap,
//       required this.depth})
//       : super(key: key);
//   final int itemId;
//   final Map<int, Future<HackerNewsComment>> commentMap;
//   final int depth;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<HackerNewsComment>(
//         future: commentMap[itemId],
//         builder: (ctx, asyncData) {
//           if (asyncData.connectionState == ConnectionState.waiting)
//             return const LoadingContainer();
//           if (!asyncData.hasData) return const SizedBox();
//           final HackerNewsComment? comment = asyncData.data;
//           final children = <Widget>[
//             CardComment(comment: comment!),
//           ];

//           comment.kids.forEach((kidId) {
//             children.add(Comment(itemId: kidId ,commentMap: commentMap,depth: depth +1));
//            });
//           return Column(
//             children: children,
//           );
//         });
//   }
// }



//  Widget getSingleComment(Map<int, Future<HackerNewsComment?>> streamSnapShotData ,int commentId) {
//     return FutureBuilder<HackerNewsComment?>(
//       future: streamSnapShotData[commentId],
//       builder: (buildcontext, AsyncSnapshot<HackerNewsComment?> itemSnapShot) {
//         if (itemSnapShot.connectionState == ConnectionState.waiting)
//           return const LoadingContainer();
//         if (!itemSnapShot.hasData) return const SizedBox();
//         return CardComment(comment: itemSnapShot.data! , streamSnapShotData :streamSnapShotData);
//       },
//     );
//   }
