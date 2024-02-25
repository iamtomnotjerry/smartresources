import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager extends ChangeNotifier {
  bool isConnect = true;

  late StreamSubscription<ConnectivityResult> subscription;

  NetworkManager() {
    subscription =
        Connectivity().onConnectivityChanged.listen(onConnectivityChanged);
  }

  void onConnectivityChanged(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      isConnect = false;
    } else {
      isConnect = true;
    }
    notifyListeners();
  }
}
