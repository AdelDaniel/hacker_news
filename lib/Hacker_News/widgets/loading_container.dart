import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListTile(
        title: greyBox(100.5),
        subtitle: greyBox(150.0),
      ),
    );
  }

  Widget greyBox(double width) => Container(
        color: Colors.grey[300],
        height: 24.0,
        width: width,
        margin: const EdgeInsets.only(top: 5, bottom: 5),
      );
}
