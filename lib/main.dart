import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_provider/models/NotesProvider.dart';
import 'package:todo_flutter_provider/screens/Home_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<NotesProvider>(
        create: (context) => NotesProvider(),
          child: Home_Screen()
      ),
    );
  }
}