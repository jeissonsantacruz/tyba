import 'package:flutter/material.dart';
import 'package:tyba/managers/router_manager.dart';
import 'package:tyba/presentation/screens/home/ui/page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        onGenerateRoute: routeManager.generateRouted,
        home: const BooksPage());
  }
}
