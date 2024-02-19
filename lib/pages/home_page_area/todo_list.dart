import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/dialogs/task_info_dialog.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:todo/utils/todo_tile.dart';

import '../../dialogs/add_new_task_dialog.dart';
import '../../dialogs/loading_indicator_dialog.dart';
import '../../validation_checks/task_info_check.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  final _titleAddTaskController = TextEditingController();
  final _textAddTaskController = TextEditingController();
  final _dueDateAddTaskController = TextEditingController();
  final _isLoaded = [true];

  List<Map<String, dynamic>> todoList = [];

  void getTasks() async {
    todoList.clear();
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('tasks')
        .where('email', isEqualTo: user?.email.toString())
        .get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          Map<String, dynamic> taskData = doc.data()! as Map<String, dynamic>;
          taskData["docId"] = doc.id.toString();
          todoList.add(taskData);
        });
      }),
    });
    setState(() {
      _isLoaded[0] = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  void saveNewTask() async {
    if (checkTaskFields(_titleAddTaskController.text.trim(), _textAddTaskController.text.trim(), _dueDateAddTaskController.text.trim(), context)) {
      DateTime now = DateTime.now();
      String date = "${now.day}.${now.month}.${now.year.toString().substring(2)} ${now.hour}:${now.minute}";
      await FirebaseFirestore.instance.collection('tasks').add({
          'email': FirebaseAuth.instance.currentUser!.email.toString(),
          'title': _titleAddTaskController.text.trim(),
          'text': _textAddTaskController.text.trim(),
          'date': date,
          'due_date': _dueDateAddTaskController.text.trim(),
          'state': "0",
      });
      getTasks();
      cl();
    }

  }

  void clearControllers() {
    setState(() {
      _textAddTaskController.clear();
      _titleAddTaskController.clear();
      _dueDateAddTaskController.clear();
    });
  }

  void cl() {
    Navigator.of(context).pop();
    clearControllers();
  }

  void createNewTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddNewTaskDialogBox(
          titleController: _titleAddTaskController,
          textController: _textAddTaskController,
          dateController: _dueDateAddTaskController,
          onSave: saveNewTask,
          onCancel: cl,
        );
      }
    );
  }

  void createTaskInfoDialog(Map<String, dynamic> taskInfo) {
    showDialog(
        context: context,
        builder: (context) {
          return TaskInfoDialog(
            taskInfo: taskInfo,
            onChanged: getTasks,
          );
        }
    );
  }

  /*
  * TODO maybe add archive functionality for tasks
  * */
  @override
  Widget build(BuildContext context) {

    return todoList.isEmpty && _isLoaded[0] ?
    const LoadingIndicatorDialog()
        :
    Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.colors.purple,

        onPressed: createNewTaskDialog,
        elevation: 0,
        child: Icon(Icons.add, color: AppTheme.colors.pinkWhite),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.separated(
            itemCount: todoList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () { createTaskInfoDialog(todoList[index]); },
                child: TodoTile(
                  title: todoList[index]["title"],
                  taskText: todoList[index]["text"],
                  createdDate: todoList[index]["date"],
                  dueDate: todoList[index]["due_date"],
                  taskState: todoList[index]["state"],
                  taskDocId: todoList[index]["docId"],
                  onChanged: getTasks,
                ),
              );
            },
          ),
        ),
      )
    );


  }
}