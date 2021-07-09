import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/Hacker_News/models/hacker_news_story_model.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:hacker_news/Hacker_News/services/hacker_news_story_service.dart';

void main() {
  test("gettopStories returned list of ints ", () async {
    //setup test cases
    const int sum = 1 + 2;
    final List<int> list = <int>[2, 2, 5, 3, 66, 45];
    final HackerNewsStoryServies hackerNewsServies = HackerNewsStoryServies();

    // the mock client help you that the get not connected to the server but instead of that
    // you return what you want in shape of response
    hackerNewsServies.client = MockClient((Request request) async {
      return Response(json.encode(list), 200);
    });

    final List<int>? newsIds = await hackerNewsServies.getTopStoriesIds();

    //expectation
    expect(sum, 3);
    expect(newsIds, list);
  });

  test("getStoryItem returned one story ", () async {
    //setup test cases
    final HackerNewsStoryServies hackerNewsServies = HackerNewsStoryServies();
    final HackerNewsStory hackerNewsStory = HackerNewsStory(
        by: 'by',
        descendants: 10,
        id: 2,
        kids: <dynamic>[],
        score: 10,
        time: 15,
        title: 'title',
        type: 'type',
        url: 'url');
    // the mock client help you that the get not connected to the server but instead of that
    // you return what you want in shape of response
    hackerNewsServies.client = MockClient((Request request) async {
      return Response(hackerNewsStory.toJson(), 200);
    });

    final HackerNewsStory? story = await hackerNewsServies.fetchStoryById(10);

    //expectation
    expect(story.toString(), hackerNewsStory.toString());
  });
}
