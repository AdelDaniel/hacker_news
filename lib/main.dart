import 'package:flutter/material.dart';

import 'Hacker_News/helper/check_connection.dart';
import 'bottom_tap_bar_screen.dart';
import 'route_generator.dart';

void main() {
  final ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: BottomTapBarScreen.pageRoute,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Hacker News',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}
