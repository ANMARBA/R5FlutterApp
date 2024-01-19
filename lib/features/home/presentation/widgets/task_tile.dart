import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_r5_app/features/home/home.dart';

class TaskTile extends StatelessWidget {
  final ToDo task;
  final VoidCallback onRemove;
  final Function(bool) onToggleState;

  const TaskTile({
    required this.task,
    required this.onRemove,
    required this.onToggleState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          task.title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            _buildTaskState(),
            const SizedBox(height: 8.0),
            Text(
              'Fecha: ${DateFormat('dd/MM/yyyy').format(task.date)}',
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onRemove,
        ),
      ),
    );
  }

  Widget _buildTaskState() {
    return GestureDetector(
      onTap: () {
        if (!task.state) {
          onToggleState(true);
        }
      },
      child: Row(
        children: [
          Icon(
            task.state ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.state ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8.0),
          Text(
            task.state ? 'Completada' : 'Pendiente',
            style: TextStyle(color: task.state ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}
