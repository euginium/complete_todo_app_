import 'package:flutter/material.dart';
import 'package:todo_app/networker.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Networker(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.blueGrey.shade700,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
