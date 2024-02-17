import 'package:flutter/material.dart';
import 'package:todo/theme/gradients.dart';
import 'package:todo/theme/text_styles.dart';

import '../theme/app_theme.dart';

class TodoTile extends StatelessWidget {

  final String title;
  final String taskText;
  final String createdDate;
  final String dueDate;
  final String taskState;

  const TodoTile({
    super.key,
    required this.title,
    required this.taskText,
    required this.createdDate,
    required this.dueDate,
    required this.taskState
  });

  // TodoTile(this.title, this.taskText, this.createdDate, this.isMarked);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        gradient: taskState == "0" ? darkPurpleGradient :
        taskState == "1" ? attentionTodoTaskGradient : doneTodoTaskGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container( // Task title
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
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80, // Установите желаемую максимальную ширину
                child: ClipRect(
                  child: Text(
                      taskText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: mainTextStyle
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
