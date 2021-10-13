import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/add_task_screen.dart';

class TodoButton extends StatelessWidget {
  const TodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),onPressed: () {
          Navigator.pushNamed(context, 'add', arguments: WidgetArguments(
            0,
            '',
            '',
            '',
            0
          ));
        });
  }
}
