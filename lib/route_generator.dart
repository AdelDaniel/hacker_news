import 'package:flutter/material.dart';

import 'Hacker_News/screens/hacker_news_main_list.dart';
import 'Hacker_News/screens/hacker_news_story_details_screen.dart';
import 'bottom_tap_bar_screen.dart';

class RouteGenerator {
  static Route<Widget> onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == BottomTapBarScreen.pageRoute) {
      return MaterialPageRoute<Widget>(
          builder: (BuildContext ctx) => BottomTapBarScreen());
    } else if (routeSettings.name == HackerNewsListScreen.pageRoute) {
      return MaterialPageRoute<Widget>(
          builder: (BuildContext ctx) => const HackerNewsListScreen());
    } else if (routeSettings.name!.startsWith('/story_id=')) {
      // final int id =
      //     int.parse(routeSettings.name!.replaceFirst('/story_id=', ''));
      // HackerNewsStory story = routeSettings.arguments as HackerNewsStory;
      return MaterialPageRoute<Widget>(
          builder: (BuildContext ctx) => const HackerNewsDetailsScreen(),
          settings: routeSettings);
    } else {
      return errorRoute();
    }
  }

  static Route<Widget> errorRoute() {
    return MaterialPageRoute<Widget>(
      builder: (BuildContext ctx) => const Scaffold(
        body: Center(
          child: Text("Oops! \n SomeThing went Wrong",
              textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
