import 'dart:convert';
import 'package:apptareas/app/model/task.dart';
import 'package:apptareas/app/repository/task_repository.dart';
import 'package:apptareas/app/view/components/h1.dart';
import 'package:apptareas/app/view/components/shape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TaskRepository taskRepository = TaskRepository();

  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    final tasks = await taskRepository.getTasks();
    print('Tareas cargadas en _loadSharedPreferences: $tasks');  // Agregado para depuración
    setState(() {
      _tasks = tasks;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Cabecera ---------------------->
          const _Header(),
          //Lista de tareas ---------------------->
          Expanded(
              child: FutureBuilder<List<Task>>(
                future: taskRepository.getTasks(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                        child: CircularProgressIndicator(),
                    );
                  }
                  if(!snapshot.hasData || snapshot.data!.isEmpty){
                    return const Center(child: Text('No hay tareas'));
                  }
                  return _TaskList(
                    snapshot.data!,
                    onTaskDoneChange: (task) {
                        task.done = !task.done;
                        taskRepository.saveTasks(snapshot.data!);
                        setState(() {});
                    },
                    onTaskDeleted: (task) {
                      setState(() {
                        _tasks.remove(task);
                      });
                    },
                  );
                },
              )
          )
        ],
      ),

      //Botones ---------------------->
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          //Eliminar tareas
          FloatingActionButton(
              onPressed: () async {
                taskRepository.deleteAllTasks();
                print('Tareas eliminadas');
                setState(() {
                  _tasks = [];
                });
                },
            mini: true,
            child: const Icon(Icons.delete_forever, size: 30),

          ),

          const SizedBox(width: 20),

          //Agregar tareas
          FloatingActionButton(
            onPressed: () => _ShowNewTaskModal(context),
            child: const Icon(Icons.add, size: 50),
          ),

        ],
      ),
    );
  }

  void _ShowNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => _NewTaskModal(onTaskCreated: (Task task) {
          taskRepository.addTask(task);
          setState(() {
            _tasks.add(task);
          });
        })
    );
  }
}

class _NewTaskModal extends StatelessWidget {
  _NewTaskModal({super.key, required this.onTaskCreated});

  final _controllerTitulo = TextEditingController();
  final _controllerDescripcion = TextEditingController();

  final void Function(Task task) onTaskCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 33,
        vertical: 23
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
          color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1('Nueva Tarea'),
          const SizedBox(height: 26),
          TextField(
            controller: _controllerTitulo,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(16)),
              ),
              hintText: 'Titulo de la tarea'
            ),
          ),

          const SizedBox(height: 26),

          TextField(
            controller: _controllerDescripcion,
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(16)),
                ),
                hintText: 'Descripción de la tarea'
            ),
          ),

          const SizedBox(height: 26),

          ElevatedButton(
              onPressed: (){
                if(_controllerTitulo.text.isNotEmpty){
                  final task = Task(_controllerTitulo.text, _controllerDescripcion.text);

                  onTaskCreated(task);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
          )
        ],
      ),

    );
  }


}

class _TaskList extends StatelessWidget {
  const _TaskList(this.taskList, {super.key, required this.onTaskDoneChange, required this.onTaskDeleted});


  final List<Task> taskList;
  final void Function(Task task) onTaskDoneChange;
  final void Function(Task task) onTaskDeleted;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const H1('Tareas'),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (_, index) => _TaskItem(
                    taskList[index],
                    onTap: () => onTaskDoneChange(taskList[index]),
                    onTaskDeleted: (task) {
                      taskList.remove(task);
                      onTaskDeleted(task);
                    },
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: taskList.length),
            )
          ]
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 291,
      decoration: const BoxDecoration(
        color: Color(0xFF40B7AD),
      ),
      child: Stack(
        children: [
          const Positioned(child: Shape()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(
                child: Image.asset(
                  'assets/images/lista-image.png',
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 13),
              const H1('Completa tus tareas', color: Color(0xFFF5F5F5)),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatefulWidget {
  const _TaskItem(this.task, {super.key, this.onTap, required this.onTaskDeleted});

  final Task task;
  final VoidCallback? onTap;
  final void Function(Task task) onTaskDeleted;


  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  final TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    widget.task.done
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank,
                    color: const Color(0xFF40B7AD),
                  ),
                  const SizedBox(width: 10),
                  Text(widget.task.title ,style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))

                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  const SizedBox(width: 5),
                  Text(widget.task.descripcion ,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200)),
                ],
              ),

              ElevatedButton(
                onPressed: () async {
                  await taskRepository.deleteTask(widget.task);
                  print('Eliminado');
                  widget.onTaskDeleted(widget.task); // Notificar al padre
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, double.minPositive),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)
                  ),
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white
                ),
                child: const Icon(Icons.delete, size: 20),
              )

            ],
          ),
        ),
      ),
    );
  }



}
