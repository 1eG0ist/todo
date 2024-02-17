import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:todo/theme/buttons/button_styles.dart';
import 'package:todo/theme/gradients.dart';
import 'package:todo/theme/text_styles.dart';
import 'package:todo/utils/todo_tile.dart';

import '../../dialogs/add_new_task_dialog.dart';
import '../../dialogs/dialogs.dart';
import '../../dialogs/loading_indicator_dialog.dart';
import '../../validation_checks/date_checks.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  final _titleAddTaskController = TextEditingController();
  final _textAddTaskController = TextEditingController();
  final _dueDateAddTaskController = TextEditingController();

  String _userNewTask = "";
  List<Map<String, dynamic>> todoList = [ // title, text, created date, date of expected completion, state
    // [
    //   "Create video",
    //   "Need to create minecraft big video tutorial with mods and shaders and a lot of more things",
    //   "21.12.23 01:22",
    //   "15.02.2024",
    //   "2"
    // ],
    // [
    //   "flutter video tutorial",
    //   "need to check this video and conspect any specific things, like you know",
    //   "21.12.23 04:12",
    //   "20.02.2024",
    //   "1"
    // ]
  ];

  void getTasks() async {
    todoList.clear();
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('tasks')
        .where('email', isEqualTo: user?.email.toString())
        .get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          todoList.add(doc.data()! as Map<String, dynamic>);
        });
      }),
    });
    print(todoList);
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }
  
  bool checkAddingTaskFields() {
    if (_titleAddTaskController.text.trim().length < 3) {
      showCustomErrDialog("Too short title", context);
      return false;
    } else if (_textAddTaskController.text.trim().length < 10) {
      showCustomErrDialog("Too short text", context);
      return false;
    } else if (!isValidDateDMY(_dueDateAddTaskController.text.trim())) {
      showCustomErrDialog("Something went wrong with due date field! Try again in day.month.year format", context);
      return false;
    }
    return true;
  }

  void saveNewTask() async {
    if (checkAddingTaskFields()) {
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

  @override
  Widget build(BuildContext context) {

    return todoList.length == 0 ?
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
              print("!!!!!!!!!!!!!!!!!!!!!!!" + todoList[index]["title"]);
              return TodoTile(
                title: todoList[index]["title"],
                taskText: todoList[index]["text"],
                createdDate: todoList[index]["date"],
                dueDate: todoList[index]["due_date"],
                taskState: todoList[index]["state"],
              );
            },
          ),
        ),
      )
    );


  }
}