import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget {
  static void show(
    BuildContext context, {
    bool useRootNavigator = false,
  }) {
    showDialog(
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Lottie.asset('assets/animations/green.json'),
      ),
      context: context,
      barrierDismissible: false,
      useRootNavigator: useRootNavigator,
    );
  }
}
