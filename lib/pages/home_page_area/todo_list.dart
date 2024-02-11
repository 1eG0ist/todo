import 'package:flutter/material.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:todo/theme/buttons/button_styles.dart';
import 'package:todo/theme/gradients.dart';
import 'package:todo/theme/text_styles.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  String _userNewTask = "";
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll(["Buy milk", "Learn Flutter", "Помыть посуду"]);
  }

  @override
  Widget build(BuildContext context) {

    void menuOpen() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
                appBar: AppBar(title: Text("Menu", style: mainTextStyle)),
                body: Text("Main menu", style: mainTextStyle)
            );
          })
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {

            return Dismissible(
              key: Key(todoList[index]),

              child: Card(
                color: Colors.transparent,

                child: Container(
                    decoration: BoxDecoration(
                        gradient: darkPurpleGradient,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            width: 1,
                            color: AppTheme.colors.black
                        )
                    ),
                    child: ListTile(
                        leading: Icon(
                            Icons.task,
                            color: AppTheme.colors.pinkWhite
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: AppTheme.colors.pinkWhite,
                          ),
                          onPressed: () {
                            setState(() {
                              todoList.removeAt(index);
                            });
                          },
                        ),
                        title: Text(todoList[index], style: mainTextStyle)
                    )
                ),

              ),

              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    todoList.removeAt(index);
                  });
                } else {
                  setState(() {
                    todoList.removeAt(index);
                  });
                }
              },

            );


          }
      ),


      floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.colors.purple,
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add task (50 symbols): ", style: mainTextStyle,),
                backgroundColor: AppTheme.colors.darkPurple,
                content: TextField( // TODO add auto focus when dialog opening
                  style: mainTextStyle,
                  onChanged: (String value) {
                    _userNewTask = value;
                  },
                  maxLength: 50,

                ),
                actions: [
                  ElevatedButton(
                      style: elevatedButtonStyle,
                      onPressed: () {
                        setState(() {
                          todoList.add(_userNewTask);
                        });

                        Navigator.of(context).pop();
                      },
                      child: Text("Save", style: mainTextStyle)
                  ),
                  ElevatedButton(
                      style: elevatedButtonStyle,
                      onPressed: () { Navigator.of(context).pop(); },
                      child: Text("Close", style: mainTextStyle)
                  )
                ],
              );
            });
          },
          child: Icon(
              Icons.add,
              color: AppTheme.colors.pinkWhite
          )
      ),
    );


  }
}