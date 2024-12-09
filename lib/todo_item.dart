import 'package:flutter/material.dart';
import 'todo.dart';
class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onTaskChanged;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onTaskChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: const Color.fromARGB(255, 255, 255, 255),
        trailing: Checkbox(
          value: todo.isDone,
          onChanged: (value) {
            onTaskChanged(todo);
          },
          activeColor: Colors.blue,
        ),
        title: Text(
          todo.todoText ?? '',
          style: TextStyle(
            fontSize: 20,
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}