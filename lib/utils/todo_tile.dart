import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/DB_crud/users_info/get_user_info.dart';
import 'package:todo/theme/gradients.dart';
import 'package:todo/theme/text_styles.dart';

import '../theme/app_theme.dart';

class TodoTile extends StatelessWidget {

  final String title;
  final String taskText;
  final String taskComplexity;
  final String createdDate;
  final String dueDate;
  final String taskState;
  final String taskDocId;
  final VoidCallback onChanged;

  const TodoTile({
    super.key,
    required this.title,
    required this.taskText,
    required this.taskComplexity,
    required this.createdDate,
    required this.dueDate,
    required this.taskState,
    required this.taskDocId,
    required this.onChanged
  });

  /*
  * TODO maybe create statistic field in user which show how many tasks he passed
  * */
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(

        ),
        children: [
          SlidableAction(onPressed: ((context) async {
              if (taskState == "2") {
                Map<String, dynamic> userInfo = await getUserInfo();
                await FirebaseFirestore.instance.collection("users").doc(userInfo["docId"]).update({
                  "tasks_points": (int.parse(userInfo["tasks_points"].toString()) + int.parse(taskComplexity)).toString()
                });
              }
              await FirebaseFirestore.instance.collection("tasks").doc(taskDocId).delete();
              onChanged();
            }),
            icon: Icons.delete_outline_rounded,
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(

        ),
        children: [
          SlidableAction(onPressed: ((context) async { // TODO undo marking
            await FirebaseFirestore.instance.collection("tasks").doc(taskDocId).update({"state": taskState == "1" ? "0" : "1"});
            onChanged();
          }),
            icon: Icons.error_outline,
            backgroundColor: Colors.brown,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          SlidableAction(onPressed: ((context) async {
            await FirebaseFirestore.instance.collection("tasks").doc(taskDocId).update({"state": "2"});
            onChanged();
          }),
            icon: Icons.done,
            backgroundColor: AppTheme.colors.doneGreen1,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          gradient: taskState == "0" ? darkPurpleGradient :
          taskState == "1" ? attentionTodoTaskGradient : doneTodoTaskGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // Task title
              SizedBox(
                width: MediaQuery.of(context).size.width/1.7,
                child: ClipRect(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bigTextStyle
                  ),
                ),
              ),
              // task date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(createdDate, style: miniDateTextStyle),
                  Text(dueDate, style: miniDateTextStyle)
                ],
              )
            ]),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: ClipRect(
                    child: Text(
                        taskText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: mainTextStyle
                    ),
                  ),
                ),
                Text(taskComplexity, style: mainTextStyle)
              ],
            )
          ],
        ),
      ),
    );
  }
}
