// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityManager {
//   final Connectivity _connectivity = Connectivity();
//   StreamSubscription<ConnectivityResult>? _subscription;

//   void startMonitoring(Function(ConnectivityResult) onChange) {
//     _subscription = _connectivity.onConnectivityChanged.listen(onChange);
//   }

//   Future<ConnectivityResult> checkConnectivity() async {
//     return await _connectivity.checkConnectivity();
//   }

//   void dispose() {
//     _subscription?.cancel();
//   }
// }
