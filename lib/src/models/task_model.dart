import 'package:flutter/cupertino.dart';

import 'dart:convert';
import 'package:meta/meta.dart';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  int? idTask;
  @required String? nameTask;
  @required String? desTask;
  @required String? dateTask;
  @required int? doneTask;

  TaskModel(
    {this.idTask, this.nameTask, this.desTask, this.dateTask, this.doneTask});

  //De mapa a objeto para recibir datos
  factory TaskModel.fromJson(Map<String, dynamic>json) {
    return TaskModel(
      idTask: json['idTask'],
      nameTask: json['nameTask'],
      desTask: json['desTask'],
      dateTask: json['dateTask'],
      doneTask: json['doneTask']
    );
  }

  //De objeto a mapa, para insertar los datos en la DB
  Map<String, dynamic> toJson() {
    return {
      'idTask': idTask,
      'nameTask': nameTask,
      'desTask': desTask,
      'dateTask': dateTask,
      'doneTask': doneTask
    };
  }
  String toString(){
    return '{ id: ${this.idTask}, name: ${this.nameTask}, desc: ${this.desTask}, date: ${this.dateTask}, done: ${this.doneTask} }';

  }
}
