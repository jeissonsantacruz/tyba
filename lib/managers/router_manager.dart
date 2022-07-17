import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tyba/presentation/screens/home/ui/page.dart';
import 'package:tyba/presentation/utils/constants.dart';

final RouteManager routeManager = RouteManager();

//Class that contains the navigation logic
class RouteManager {
  //Method that creates the routes and handles the navigation logic
  Route<dynamic> generateRouted(RouteSettings settings) {
    // Method that redirect the route
    switch (settings.name) {
      case kHomeRoute:
        return MaterialPageRoute<void>(
            builder: (BuildContext context) => const BooksPage());
      default:
        return MaterialPageRoute<void>(
            builder: (BuildContext context) => const BooksPage());
    }
  }

  //Method that directs the user to another screen, with  or  without botton navigation
  Future<void> navigateRoute(
      {required String name,
      Object? arguments,
      BuildContext? context,
      bool replace = false}) {
    if (replace) {
      return Navigator.of(context!)
          .pushNamedAndRemoveUntil(name, (route) => false);
    }
    return Navigator.of(context!).pushNamed(name, arguments: arguments);
  }
}
