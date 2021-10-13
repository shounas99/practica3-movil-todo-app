import 'dart:io';

import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo_app/src/models/task_model.dart';

class DatabaseTask {
  final _nameDB = "TaskDB";
  final _versionDB = 1;
  final _nameTBL = "Tasks";

  static Database? _database;
  static final DatabaseTask db = DatabaseTask._();
  DatabaseTask._();
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //--------------------Inicializo DB--------------------
  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nameDB);
    return openDatabase(rutaDB, version: _versionDB, onCreate: _createTable);
  }

  //-------------------Creacion Tabla Tasks-------------------
  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_nameTBL (
          idTask INTEGER PRIMARY KEY,
          nameTask TEXT NOT NULL,
          desTask TEXT NOT NULL,
          dateTask TEXT NOT NULL,
          doneTask INT NOT NULL
          )
      ''');
  }

  //-------------------Insertar datos-------------------
  Future<int> insertTask(TaskModel taskModel) async {
    final conexion = await database;
    // final res = await db.insert();
    final res = await conexion!.insert(_nameTBL, taskModel.toJson());
    print('-----Prueba2-----');
    print(res);
    return res;
  }

  //-------------------Borrar datos-------------------
  Future<int> deleteByIdTask(int idTask) async {
    var conexion = await database;
    final res = await conexion!
        .delete(_nameTBL, where: 'idTask = ?', whereArgs: [idTask]);
    print('-----Prueba delete-----');
    print(res);
    return res;
  }

  //-------------------Obtener todas las tareas-------------------
  Future<List<TaskModel>> getAllTasks() async {
    var conexion = await database;
    var result = await conexion!.query(_nameTBL);
    return result.map((taskMap) => TaskModel.fromJson(taskMap)).toList();
  }
  //-------------------Actualizar tarea-------------------
  Future<int> updateTask(TaskModel updatedTask)async{
    var conexion = await database;
    var result = conexion!.update(_nameTBL, updatedTask.toJson(), where: 'idTask = ?', whereArgs: [updatedTask.idTask]);
    print('-----Prueba update-----');
    print(result);
    return result;
  }
  //-------------------Actualizar tareas entregadas o no-------------------
   Future<int> updateTaskDone(int idTask, int doneTask)async{
    var conexion = await database;
    if(doneTask == 0){
      doneTask = 1;
    } else{
      doneTask = 0;
    }
    var result = conexion!.rawUpdate('''
      UPDATE $_nameTBL
      SET doneTask = $doneTask
      WHERE idTask = $idTask
      ''',
    );
    return result;
  }

  //-------------------Obtener una sola tarea-------------------
  Future<TaskModel> getTask(int idTask) async {
    var conexion = await database;
    var result = await conexion!
        .query(_nameTBL, where: 'idTask = ?', whereArgs: [idTask]);
    return TaskModel.fromJson(result.first);
  }

  //-------------------Obtener tareas entregadas-------------------
  Future<List<TaskModel>> getTaskByDone(int doneTask) async {
    var conexion = await database;
    var result = await conexion!
        .query(_nameTBL, where: 'doneTask = ?', whereArgs: [doneTask]);
    return result.map((taskMap) => TaskModel.fromJson(taskMap)).toList();
  }
}
