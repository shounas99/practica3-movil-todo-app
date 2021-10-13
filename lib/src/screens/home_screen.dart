import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/src/providers/ui_provider.dart';
import 'package:todo_app/src/providers/task_list_provider.dart';

import 'package:todo_app/src/screens/todo_screen.dart';

import 'package:todo_app/src/widgets/custom_navigator.dart';
import 'package:todo_app/src/widgets/todo_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Tareas escolares'),
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const TodoButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//Implemente otra clase para el cambio de ventanas
class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    
    final taskListProvider = Provider.of<TaskListProvider>(context, listen: false);

    //Cambiar de pantalla
    switch (currentIndex) {
      case 0:
        taskListProvider.refreshTask();
        return TodoScreen();
      case 1:
        taskListProvider.doneTask(1);
        return TodoScreen();

      default:
        return TodoScreen();
    }
  }
}

