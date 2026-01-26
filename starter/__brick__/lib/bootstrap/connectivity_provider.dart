import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityProvider = AsyncNotifierProvider<ConnectivityNotifier, bool>(isAutoDispose: false, ConnectivityNotifier.new);

class ConnectivityNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final subscription = Connectivity().onConnectivityChanged.listen((results) async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!ref.mounted) return;
      state = AsyncData(await _checkInternet(results));
    });
    ref.onDispose(subscription.cancel);
    final results = await Connectivity().checkConnectivity();
    return _checkInternet(results);
  }

  Future<bool> _checkInternet(List<ConnectivityResult> results) async {
    final hasInterface = results.isNotEmpty && !results.contains(ConnectivityResult.none);

    if (!hasInterface) return false;

    try {
      final lookup = await InternetAddress.lookup('google.com');
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void retry(){
    ref.invalidateSelf();
  }
}
