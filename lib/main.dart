import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'todo.dart';
import 'todo_item.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Disable DevicePreview in release mode
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List of tasks
  final List<ToDo> todoList = ToDo.todoList();
  final TextEditingController taskController = TextEditingController();

  void toggleTaskStatus(ToDo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

   void addTask(String taskText) {
    if (taskText.isNotEmpty) {
      setState(() {
        todoList.add(
          ToDo(
            todoText: taskText,
          ),
        );
      });
      taskController.clear(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tasks',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60), 
              child: ListView(
                children: [
                  for (ToDo todo in todoList)
                    ToDoItem(
                      todo: todo,
                      onTaskChanged: toggleTaskStatus,
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: TextField(
                          controller: taskController,
                          decoration: const InputDecoration(
                            hintText: 'Add a new task...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
                      onPressed: () {
                        addTask(taskController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}