import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import '../helper/check_connection.dart';

class NoInternetWidget extends StatelessWidget {
  // final Connectivity _connectivity = Connectivity();

  final ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: connectionStatus.connectionChange,
        builder: (BuildContext buildContext,
            AsyncSnapshot<bool> connectionSnapShot) {
          // ignore: avoid_print
          print(connectionSnapShot.connectionState);
          // ignore: avoid_print
          print(connectionSnapShot.data.toString());
          if (!connectionSnapShot.hasData) return const SizedBox();
          if (!connectionSnapShot.data!) {
            return Container(
              height: 20.0,
              color: Colors.red,
              child: const Center(
                  child: Text(
                "Opss..  Check Inertnet connection !",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )),
            );
          }
          return const SizedBox();
        });
  }
}
