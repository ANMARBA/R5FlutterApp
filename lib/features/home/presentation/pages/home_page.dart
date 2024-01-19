import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_r5_app/core/core.dart';
import 'package:flutter_r5_app/features/home/home.dart';
import 'package:flutter_r5_app/features/user/user.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  BuildContext? _scaffoldContext;
  String auxTaskID = '';
  List<ToDo> auxTasks = [];

  @override
  void initState() {
    super.initState();
    _getTODOs();
  }

  void _getTODOs() {
    Future.microtask(() {
      ref.read(tasksNotifierProvider.notifier).getTODOs();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _signOut() async {
    var authService = getIt.get<AuthService>();
    await authService.signOut();
    Navigator.pushReplacement(
      _scaffoldContext!,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksNotifierProvider);

    _listenToTasksNotifier();
    _listenToDeleteTaskNotifier();
    _listenToUpdateStateTaskNotifier();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tareas'),
        actions: [
          Builder(
            builder: (BuildContext scaffoldContext) {
              _scaffoldContext = scaffoldContext;
              return IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: _signOut,
              );
            },
          ),
        ],
      ),
      body: _buildTasksBody(tasks),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget? _buildTasksBody(TasksState tasks) {
    return tasks.whenOrNull(
      getTasks: (tasks, isLoading, failure) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (failure != null) return ErrorManagement(onRetry: _getTODOs);
        if (auxTasks.isEmpty) {
          return const Center(
            child: Text(
              'No tienes tareas actualmente.',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemBuilder: (_, i) {
              final task = auxTasks[i];
              return TaskTile(
                task: task,
                onRemove: () {
                  auxTaskID = task.id;
                  ref
                      .read(deleteTaskNotifierProvider.notifier)
                      .deleteTODO(task.id);
                },
                onToggleState: (state) {
                  auxTaskID = task.id;
                  ref
                      .read(updateStateTaskNotifierProvider.notifier)
                      .updateStateTODO(task.id, state);
                },
              );
            },
            itemCount: auxTasks.length,
          ),
        );
      },
    );
  }

  void _listenToTasksNotifier() {
    ref.listen(
      tasksNotifierProvider,
      (_, next) {
        next.whenOrNull(
          getTasks: (tasks, _, __) {
            auxTasks = [...tasks];
          },
        );
      },
    );
  }

  void _listenToDeleteTaskNotifier() {
    ref.listen(
      deleteTaskNotifierProvider,
      (_, next) {
        const messageError = 'Ocurrió un error. Por favor, inténtelo de nuevo.';
        next.whenOrNull(
          deleteTask: (successful, isLoading, failure) {
            if (isLoading) return;
            if (failure != null) {
              return _showSnackBar(failure.message ?? messageError);
            }
            if (successful) {
              _showSnackBar('Tarea eliminada correctamente.');
              setState(() {
                auxTasks.removeWhere((task) => task.id == auxTaskID);
              });
            } else {
              _showSnackBar(messageError);
            }
          },
        );
      },
    );
  }

  void _listenToUpdateStateTaskNotifier() {
    ref.listen(
      updateStateTaskNotifierProvider,
      (_, next) {
        const messageError = 'Ocurrió un error. Por favor, inténtelo de nuevo.';
        next.whenOrNull(
          updateStateTask: (successful, isLoading, failure) {
            if (isLoading) return;
            if (failure != null) {
              return _showSnackBar(failure.message ?? messageError);
            }
            if (successful) {
              _showSnackBar('Tarea actualizada correctamente.');
              setState(() {
                final index =
                    auxTasks.indexWhere((task) => task.id == auxTaskID);
                if (index != -1) {
                  auxTasks[index] = auxTasks[index].copyWith(state: true);
                }
              });
            } else {
              _showSnackBar(messageError);
            }
          },
        );
      },
    );
  }
}
