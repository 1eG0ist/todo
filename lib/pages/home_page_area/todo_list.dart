import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/dialogs/task_info_dialog.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:todo/utils/todo_tile.dart';

import '../../DB_crud/delete_task.dart';
import '../../dialogs/add_new_task_dialog.dart';
import '../../dialogs/confirmation_dialog.dart';
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
  final _complexityAddTaskController = TextEditingController(text: "1");
  final _isNotLoaded = [true];

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
      _isNotLoaded[0] = false;
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
          'complexity': _complexityAddTaskController.text.trim(),
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
      _complexityAddTaskController.text = "1";
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
          complexityController: _complexityAddTaskController,
          onSave: saveNewTask,
          onCancel: cl,
        );
      }
    );
  }

  void deleteAllTasks() async {
    bool result = await ConfirmationDialog.showConfirmationDialog(
        context,
        "Do you want delete all tasks? (points will be awarded for all completed tasks)"
    );

    if (result) {
      todoList.forEach((task) {
        deleteTask(task["state"], task["complexity"], task["docId"], () {});
      });
      setState(() {
        todoList = [];
      });
    }
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

    return todoList.isEmpty && _isNotLoaded[0] ?
    const LoadingIndicatorDialog()
        :
    Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              backgroundColor: AppTheme.colors.purple,

              onPressed: deleteAllTasks,
              elevation: 0,
              child: Icon(Icons.delete_sweep_outlined, color: AppTheme.colors.pinkWhite),
            ),
            FloatingActionButton(
              backgroundColor: AppTheme.colors.purple,

              onPressed: createNewTaskDialog,
              elevation: 0,
              child: Icon(Icons.add, color: AppTheme.colors.pinkWhite),
            ),
          ],
        ),
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
                  taskComplexity: todoList[index]["complexity"],
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