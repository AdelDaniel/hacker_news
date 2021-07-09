import 'dart:async';

import 'package:flutter/material.dart';

import '../bloc_using_inherited_widgets/stories_bloc/stories_provider.dart';
import '../models/hacker_news_story_model.dart';
import 'loading_container.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({Key? key, required this.newsId}) : super(key: key);
  final int newsId;
  // static const String storyIdRoute = '/story_id=';

  @override
  Widget build(BuildContext context) {
    final StoriesBloc? _bloc = StoriesProvider.of(context);
    return StreamBuilder<Map<int, Future<HackerNewsStory?>>>(
      stream: _bloc!.itemOutput,
      builder: (BuildContext buildcontext,
          AsyncSnapshot<Map<int, Future<HackerNewsStory?>>> streamSnapShot) {
        // print('stream snaphshot state: ${streamSnapShot.connectionState}');
        // print('stream snaphshot data: ${streamSnapShot.data}');
        if (streamSnapShot.connectionState == ConnectionState.waiting) {
          return const LoadingContainer();
        }
        if (!streamSnapShot.hasData) return const SizedBox();
        return FutureBuilder<HackerNewsStory?>(
          future: streamSnapShot.data![newsId],
          builder: (BuildContext buildcontext,
              AsyncSnapshot<HackerNewsStory?> itemSnapShot) {
            if (itemSnapShot.connectionState == ConnectionState.waiting) {
              return const LoadingContainer();
            }
            if (!itemSnapShot.hasData) return const SizedBox();
            return itemTile(itemSnapShot.data!);
          },
        );
      },
    );
  }

  Widget itemTile(HackerNewsStory story) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Builder(
        builder: (BuildContext context) => ListTile(
          onTap: () => Navigator.pushNamed(context, '/story_id=${story.id}',
              arguments: story),
          title: Text(story.title),
          subtitle: Text("${story.score} Votes"),
          trailing: Column(
            children: <Widget>[
              const Icon(Icons.comment),
              Text('${story.descendants}')
            ],
          ),
        ),
      ),
    );
  }

  // Widget _circularProgress() => const Center(
  //     child: Padding(
  //         padding: const EdgeInsets.all(60.0),
  //         child: const CircularProgressIndicator()));
}
