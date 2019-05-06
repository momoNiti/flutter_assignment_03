import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/ui/completed_screen.dart';
import 'package:flutter_assignment_03/ui/new_subject_screen.dart';
import 'package:flutter_assignment_03/ui/task_screen.dart';


class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoScreenState();
  }
}

class TodoScreenState extends State<TodoScreen>{

  int _selectedIndex = 0;
  final _widgetOptions = [
    Task(),
    Completed()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              primaryColor: Colors.blue,
              textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.grey)
              )
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  title: Text("Task"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done_all),
                  title: Text("Completed"),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      });
  }
}