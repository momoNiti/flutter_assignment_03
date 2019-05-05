import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/ui/todo_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/" :(context) => TodoScreen(),
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}