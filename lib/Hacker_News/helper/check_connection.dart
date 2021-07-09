import 'dart:async'; //For StreamController/Stream
import 'dart:io'; //InternetAddress utility

import 'package:connectivity/connectivity.dart';

class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton =
      ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController<bool> connectionChangeController =
      StreamController<bool>.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream<bool> get connectionChange => connectionChangeController.stream;

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    final bool previousConnection = hasConnection;

    try {
      final List<InternetAddress?> result =
          await InternetAddress?.lookup('google.com');
      if (result.isNotEmpty && result[0]!.rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    } catch (e) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }
}




// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';

// enum connectionStatus { Mobile, WiFi, None }

// class Connection {
//   // connectionStatus _networkStatus1 = connectionStatus.None ;
//   // connectionStatus _networkStatus2 = connectionStatus.None;
//   // connectionStatus _networkStatus3 = connectionStatus.None;

//   Connectivity _connectivity = Connectivity();

//   static final Connection _connection = Connection._internal();
//   Connection._internal();
//   factory Connection() => _connection;

// // method 1
//   Future<connectionStatus> checkConnectivity() async {
//     var connectivityResult = await _connectivity.checkConnectivity();
//     return getConnectionValue(connectivityResult);
//   }

// // Method2 - Using Subscription
//   late StreamSubscription<ConnectivityResult> _subscription;
//   void checkConnectivityUsingStreamSubscription() async {
//     // Subscribe to the connectivity change
//     _subscription =
//         _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       // _networkStatus2 = getConnectionValue(result);
//     });
//   }

// //
// //method3
//   StreamController<connectionStatus> connectionStatusController =
//       StreamController<connectionStatus>();
//   // Stream is like a pipe, you add the changes to the pipe, it will
//   // come out on the other side.
//   // Create the Constructor

//   connectivityService() {
//     // Subscribe to the connectivity changed stream
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       connectionStatusController.add(getConnectionValue(result));
//     });
//   }

//   Stream<connectionStatus> get connectionval =>
//       connectionStatusController.stream;

// // Method to convert the connectivity to a string value
//   connectionStatus getConnectionValue(var connectivityResult) {
//     switch (connectivityResult) {
//       case ConnectivityResult.mobile:
//         return connectionStatus.Mobile;
//       case ConnectivityResult.wifi:
//         return connectionStatus.WiFi;
//       case ConnectivityResult.none:
//         return connectionStatus.None;
//       default:
//         return connectionStatus.None;
//     }
//   }

//   void dispose() {
//     _subscription.cancel();
//   }
// }
