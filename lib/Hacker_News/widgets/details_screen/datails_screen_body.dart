import 'package:flutter/material.dart';

import '../../models/hacker_news_story_model.dart';
import 'build_comments.dart';

class DetailsScreenBody extends StatelessWidget {
  const DetailsScreenBody({Key? key, required this.story}) : super(key: key);
  final HackerNewsStory story;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          buildStoryDetails(),
          Expanded(child: BuildComments(storyKids: story.kids.cast<int>())),
        ],
      ),
    );
  }

  Widget buildStoryDetails() {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(15),
          child: Text(
            story.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25),
          ),
        ),
        moreInfos("By: ${story.by}"),
        moreInfos("Vote: ${story.score}"),
        moreInfos("Type: ${story.type}"),
        moreInfos(
            "Date: ${DateTime.fromMillisecondsSinceEpoch(story.time * 1000)}"),
      ],
    );
  }

  Widget moreInfos(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
