import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/models/task_model.dart';
import 'package:todo_app/src/providers/task_list_provider.dart';
import 'package:todo_app/src/providers/task_values_provider.dart';

class AddTaskScreen extends StatefulWidget {
 
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String? _fechaToString;
  String? pruebaText = '';

  @override
  Widget build(BuildContext context) {
    //Argumentos para mi DB
    final args = ModalRoute.of(context)!.settings.arguments as WidgetArguments;

    //Declaro provider TaskValuesProvider
    final taskValuesProvider = Provider.of<TaskValuesProvider>(context);
    
    //Inicializar mi provider de TaskListProvider
    final taskListProvider = Provider.of<TaskListProvider>(context, listen: false);

    //Condicion para editar o crear
    if (args.idTask != 0) {
      taskValuesProvider.nameTask = args.nameTask;
      taskValuesProvider.desTask = args.desTask;
    }
    return Scaffold(
      appBar: AppBar(
        title: args.idTask != 0 ? const Text('Editar Tarea') : const Text('Agregar tarea'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _crearFecha(),
          const Divider(),
          _crearNombre(args.idTask != 0 ? args.nameTask! : ''),
          const Divider(),
          _crearDescripcion(args.idTask != 0 ? args.desTask! : ''),
          const Divider(),
          ElevatedButton(
            onPressed: (){
              // print('Nombre: ${taskValuesProvider.nameTask} - Descripcion: ${taskValuesProvider.desTask} - Fecha: ${taskValuesProvider.dateTask}');
              // print('Nombre: ${taskValuesProvider.nameTask} - Descripcion: ${taskValuesProvider.desTask} - Fecha editada: ${taskValuesProvider.dateTask}');
              // print('Fecha pruebaText: $pruebaText');
              if (args.idTask!= 0) {
                taskListProvider.updateTaskById(args.idTask!, taskValuesProvider.nameTask!, taskValuesProvider.desTask!, taskValuesProvider.dateTask!);
              } else {
                taskListProvider.createTask(taskValuesProvider.nameTask!, taskValuesProvider.desTask!, taskValuesProvider.dateTask!);
              }
                taskListProvider.refreshTask();
                Navigator.pop(context);

            },
            child: const Text('Crear tarea'),
          )
        ],
      ),
    );
  }

  Widget _crearNombre(String argsNameTask) {
    //inicializar mi provider
    final taskValuesProvider = Provider.of<TaskValuesProvider>(context);

    return TextFormField(
      initialValue: argsNameTask,

      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Nombre tarea',
          labelText: 'Nombre tarea',
          icon: const Icon(Icons.assignment_outlined)),
      onChanged: (value) => taskValuesProvider.nameTask = value,
    );
  }

  Widget _crearDescripcion(String argsDesTask) {
    //inicializar mi provider
    final taskValuesProvider = Provider.of<TaskValuesProvider>(context);

    return TextFormField(
      initialValue: argsDesTask,

      maxLines: null,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Descripción de la tarea',
          labelText: 'Descripción de la tarea',
          icon: const Icon(Icons.assignment_outlined)),
      onChanged: (value) => taskValuesProvider.desTask = value,
    );
  }

  Widget _crearFecha() {
    //inicializar mi provider
    final taskValuesProvider = Provider.of<TaskValuesProvider>(context);
    //Inicializo variable de fecha
   
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async{
          //Metodo para seleccionar fecha
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now() ,
              firstDate: DateTime(2021),
              lastDate: DateTime(2025),
            );
            if (picked != null) {
              setState(() {
                String pruebaFechaMes = _validarFechas(true, picked);
                String pruebaFechaDia = _validarFechas(false, picked);
                _fechaToString = '${picked.year}-$pruebaFechaMes-$pruebaFechaDia';
                // _controllerDateTask.text = _fechaToString!;
                taskValuesProvider.dateTask = _fechaToString;
                //Se muestre la fecha seleccionada en mi TextFormField
                pruebaText = _fechaToString;
                print('Fecha pruebaText: $pruebaText');
                print('Fecha task: ${taskValuesProvider.dateTask}');
              });
            } 
          },         
          icon: const Icon(Icons.calendar_today_outlined)
        ),
        Text(pruebaText!),
      ],
    );
  }
  
  //Metodo para validar meses y dias con 1 solo digito
  _validarFechas(bool esMes, DateTime fecha) {
    String nuevaFecha;
    switch (esMes ? fecha.month.toString() : fecha.day.toString()) {
      case '1':
        nuevaFecha = '01';
        break;

      case '2':
        nuevaFecha = '02';
        break;

      case '3':
        nuevaFecha = '03';
        break;

      case '4':
        nuevaFecha = '04';
        break;

      case '5':
        nuevaFecha = '05';
        break;

      case '6':
        nuevaFecha = '06';
        break;

      case '7':
        nuevaFecha = '07';
        break;

      case '8':
        nuevaFecha = '08';
        break;
      case '9':
        nuevaFecha = '09';
        break;

      default:
        nuevaFecha = esMes ? fecha.month.toString() : fecha.day.toString();
    }
    return nuevaFecha;
  }
}

//Clase para los argumentos de la DB
class WidgetArguments {
  final int? idTask;
  final String? nameTask;
  final String? desTask;
  final String? dateTask;
  final int? doneTask;

  WidgetArguments(this.idTask, this.nameTask, this.desTask, this.dateTask, this.doneTask);

}
