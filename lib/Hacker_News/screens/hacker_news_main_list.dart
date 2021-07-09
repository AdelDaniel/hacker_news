import 'package:flutter/material.dart';
import '../bloc_using_inherited_widgets/stories_bloc/stories_provider.dart';
import '../widgets/main_screen_body.dart';

class HackerNewsListScreen extends StatelessWidget {
  static const String pageRoute = "/Hacker_News_List_Screen";

  const HackerNewsListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(child: const Scaffold(body: MainScreenBody()));
  }
}
