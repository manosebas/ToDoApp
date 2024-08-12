import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apptareas/app/model/task.dart';

class TaskRepository {
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    jsonTasks.add(jsonEncode(task.toJson()));
    print('Tareas agregada: $jsonTasks');  // Agregado para depuración
    return prefs.setStringList('tasks', jsonTasks);
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    print('Tareas cargadas: $jsonTasks');  // Agregado para depuración
    return jsonTasks.map((jsonTask) => Task.fromJson(jsonDecode(jsonTask))).toList();
  }

  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => jsonEncode(e.toJson())).toList();
    print('Tareas guardadas: $jsonTasks');  // Agregado para depuración
    return prefs.setStringList('tasks', jsonTasks);
  }

  Future<Future<bool>> deleteAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    print('Todas las tareas eliminadas');  // Agregado para depuración
    return prefs.remove('tasks');
  }

  Future<bool> deleteTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    final taskToRemove = jsonEncode(task.toJson());
    jsonTasks.remove(taskToRemove);
    print('Tarea eliminada');  // Agregado para depuración
    return prefs.setStringList('tasks', jsonTasks);
  }


}
