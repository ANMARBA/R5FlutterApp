import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_r5_app/features/home/home.dart';

class TaskFormPage extends ConsumerStatefulWidget {
  const TaskFormPage({super.key});

  @override
  ConsumerState<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends ConsumerState<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _completed = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _clearData() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _completed = false;
      _selectedDate = DateTime.now();
    });
    FocusScope.of(context).unfocus();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(tasksNotifierProvider.notifier).addTODO(AddTODOParams(
            title: _titleController.text,
            description: _descriptionController.text,
            state: _completed,
            date: _selectedDate,
          ));
    }
  }

  void _getTODOs() {
    Future.microtask(
      () => ref.read(tasksNotifierProvider.notifier).getTODOs(),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      tasksNotifierProvider,
      (_, next) {
        const messageError = 'Ocurrió un error. Por favor, inténtelo de nuevo.';
        next.whenOrNull(
          addTask: (successful, isLoading, failure) {
            if (isLoading) {
              return;
            }
            if (failure != null) {
              return _showSnackBar(context, failure.message ?? messageError);
            }
            if (successful) {
              _clearData();
              _showSnackBar(context, 'Tarea creada correctamente.');
              _getTODOs();
            } else {
              _showSnackBar(context, messageError);
            }
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un título.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Completada:'),
                  Checkbox(
                    value: _completed,
                    onChanged: (value) {
                      setState(() {
                        _completed = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Fecha:'),
                  const SizedBox(width: 8.0),
                  Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _showDatePicker,
                    child: const Text('Seleccionar Fecha'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
