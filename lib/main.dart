import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/providers/task_list_provider.dart';
import 'package:todo_app/src/providers/task_values_provider.dart';
import 'package:todo_app/src/providers/ui_provider.dart';
import 'package:todo_app/src/screens/add_task_screen.dart';
// import 'package:todo_app/src/providers/ui_provider.dart';

import 'package:todo_app/src/screens/home_screen.dart';
import 'package:todo_app/src/screens/todo_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiProvider()
        ),
        ChangeNotifierProvider(
          create: (_) => TaskListProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO App',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'todo': (_) => TodoScreen(),
          'add': (_) => ChangeNotifierProvider(create: (_) => TaskValuesProvider(), child: AddTaskScreen(),)
          
        },
        theme: ThemeData.dark(),
      ),
    );
  }
}
