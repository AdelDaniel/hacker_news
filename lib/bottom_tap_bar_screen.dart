import 'package:flutter/material.dart';
import 'Hacker_News/screens/hacker_news_main_list.dart';

class BottomTapBarScreen extends StatelessWidget {
  static const String pageRoute = "BottomTapBarScreen";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Image.asset('assets/app_icon.png', width: 25, height: 25),
              const Text(' Hacker News')
            ],
          ),
          bottom: const TabBar(
            tabs: <Tab>[
              Tab(icon: Icon(Icons.contacts), text: "Hacker News Stories "),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            HackerNewsListScreen(),
          ],
        ),
      ),
    );
  }
}
