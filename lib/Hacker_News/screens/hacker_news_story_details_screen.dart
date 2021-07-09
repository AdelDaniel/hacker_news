import 'package:flutter/material.dart';

import '../bloc_using_inherited_widgets/comments_bloc/comments_provider.dart';
import '../models/hacker_news_story_model.dart';
import '../widgets/details_screen/datails_screen_body.dart';

class HackerNewsDetailsScreen extends StatelessWidget {
  static const String routeName = "?Hacker_News_Details_Screen";
  const HackerNewsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HackerNewsStory story =
        ModalRoute.of(context)!.settings.arguments as HackerNewsStory;

    return CommentsProvider(
      child: Scaffold(
        body: Center(
          child: DetailsScreenBody(story: story),
        ),
      ),
    );
  }
}
