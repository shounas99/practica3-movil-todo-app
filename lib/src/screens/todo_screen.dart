import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/src/providers/task_list_provider.dart';
import 'package:todo_app/src/screens/add_task_screen.dart';

class TodoScreen extends StatelessWidget {
  // const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final taskListProvider = Provider.of<TaskListProvider>(context);
  final tasks = taskListProvider.tasks;

  //Metodo para validar fechas de vencimiento
  expiredTask(String dateTask){
    final dateNow = DateTime.now();

    final date = DateTime.parse(dateTask); //String que pasare a fecha
    if(date.compareTo(dateNow) > 0){
      return false;
    } else {
      return true;
    }
  }
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          child: Card(
            shadowColor: Colors.blue,
            elevation: 10.0,
            child: Column(
              children: <Widget> [
              Text('${tasks[index]!.nameTask}',style:  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),
              Text('${tasks[index]!.desTask}'),
              expiredTask(tasks[index]!.dateTask!) == false ? Text('${tasks[index]!.dateTask}') : Text('La tarea con fecha: ${tasks[index]!.dateTask} ha vencido', style: const TextStyle(color: Colors.red,fontStyle: FontStyle.italic)),
              tasks[index]!.doneTask == 0 ? const Text('Tarea por hacer') : const Text('Tarea entregada'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  expiredTask(tasks[index]!.dateTask!) == false
                  ? IconButton(
                    onPressed: (){
                      taskListProvider.updateTaskDone(tasks[index]!.idTask!, tasks[index]!.doneTask!);
                    },
                    icon: const Icon(Icons.task_alt_rounded)
                  ): const Text(''),
                  expiredTask(tasks[index]!.dateTask!) == false
                  ? IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, 'add', arguments: WidgetArguments(
                        tasks[index]!.idTask,
                        tasks[index]!.nameTask,
                        tasks[index]!.desTask,
                        tasks[index]!.dateTask,
                        tasks[index]!.doneTask   
                      ));
                    },
                    icon: const Icon(Icons.edit)
                  ): const Text(''),
                  
                  IconButton(
                    onPressed: (){
                      taskListProvider.deleteTask(tasks[index]!.idTask!);
                    },
                    icon: const Icon(Icons.delete_outlined)
                  ),
                ]
              )
              ],
            ),
          ),
        )
      )
    );
  }
}