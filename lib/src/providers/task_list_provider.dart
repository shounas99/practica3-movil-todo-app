//Clase que me mostrara mi lista de tareas

import 'package:flutter/material.dart';
import 'package:todo_app/src/database/database_task.dart';
import 'package:todo_app/src/models/task_model.dart';

class TaskListProvider extends ChangeNotifier{
  //Mi obj de tareas
  List<TaskModel?> tasks = [];

  //-----------Todas las tareas-----------
  refreshTask() async{
    final tasks = await DatabaseTask.db.getAllTasks();
    this.tasks = [...tasks];
    notifyListeners();
  }
  //-----------Tareas entregadas-----------
  doneTask(int doneTask) async{
    final tasks = await DatabaseTask.db.getTaskByDone(doneTask);
    this.tasks = [...tasks];
    notifyListeners();
  }
  //-----------Crear Tarea-----------
  createTask(String nameTask, String desTask, String dateTask) async{
    final newTask = TaskModel(
      nameTask: nameTask,
      desTask: desTask,
      dateTask: dateTask,
      doneTask: 0
    );
    final newTaskId = await DatabaseTask.db.insertTask(newTask);
    newTask.idTask = newTaskId;
    notifyListeners();
  }
  //-----------Actualizar Tarea-----------
  updateTaskById(int idTask, String nameTask, String desTask, String dateTask)async{
    final updateTask = TaskModel(
      idTask: idTask,
      nameTask: nameTask,
      desTask: desTask,
      dateTask: dateTask,
      doneTask: 0
    );
    final updateTaskById = await DatabaseTask.db.updateTask(updateTask);
    updateTask.idTask = updateTaskById;
    notifyListeners();

  }
  //-----------Actualizar Tarea terminada-----------
  updateTaskDone(int idTask, int doneTask)async{
    await DatabaseTask.db.updateTaskDone(idTask, doneTask);
    notifyListeners();
  }
  //-----------Borrar tarea por id-----------
  deleteTask(int idTask)async {
    await DatabaseTask.db.deleteByIdTask(idTask);
    tasks.removeWhere((deleteTask) => deleteTask!.idTask == idTask);
    notifyListeners();
  }
  

}

