import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../theme/buttons/dialog_actions_button.dart';
import '../theme/text_fields/text_field_decorations/default_text_field_decoration.dart';
import '../theme/text_styles.dart';
import '../validation_checks/task_info_check.dart';

class TaskInfoDialog extends StatelessWidget {

  final Map<String, dynamic> taskInfo;
  final VoidCallback onChanged;

  TaskInfoDialog({
    super.key,
    required this.taskInfo,
    required this.onChanged,
  });




  @override
  Widget build(BuildContext context) {
    final _titleChangeTaskController = TextEditingController(text: taskInfo["title"]);
    final _textChangeTaskController = TextEditingController(text: taskInfo["text"]);
    final _dueDateChangeTaskController = TextEditingController(text: taskInfo["due_date"]);
    void onSave() async {
      if (checkTaskFields(_titleChangeTaskController.text.trim() ,_textChangeTaskController.text.trim(), _dueDateChangeTaskController.text.trim(), context)) {
        await FirebaseFirestore.instance.collection("tasks").doc(taskInfo["docId"]).update({
          'title': _titleChangeTaskController.text.trim(),
          'text': _textChangeTaskController.text.trim(),
          'due_date': _dueDateChangeTaskController.text.trim(),
        });
        onChanged();
        Navigator.of(context).pop();
      };
    }
    return AlertDialog(

      backgroundColor: AppTheme.colors.darkPurple,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // title field
            Container(
                decoration: defaultBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    controller: _titleChangeTaskController,
                    minLines: 1,
                    maxLines: 3,
                    inputFormatters: [LengthLimitingTextInputFormatter(50)],
                    style: mainTextStyle,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title, color: AppTheme.colors.pinkWhite),
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(
                          color: AppTheme.colors.hintPinkWhite,
                        )
                    ),
                  ),
                )
            ),
            const SizedBox(height: 10),
            // Text field
            Container(
                decoration: defaultBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    controller: _textChangeTaskController,
                    inputFormatters: [LengthLimitingTextInputFormatter(300)],
                    style: mainTextStyle,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.subtitles_outlined, color: AppTheme.colors.pinkWhite),
                        border: InputBorder.none,
                        hintText: "Text",
                        hintStyle: TextStyle(
                          color: AppTheme.colors.hintPinkWhite,
                        )
                    ),
                  ),
                )
            ),
            const SizedBox(height: 10),
            /*
            * TODO maybe use calendar picker widget for choosing due date
            * */
            //due date
            Container(
                decoration: defaultBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    maxLines: 1,
                    controller: _dueDateChangeTaskController,
                    inputFormatters: [LengthLimitingTextInputFormatter(300)],
                    style: mainTextStyle,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range, color: AppTheme.colors.pinkWhite),
                        border: InputBorder.none,
                        hintText: "due date (date d.m.y)",
                        hintStyle: TextStyle(
                          color: AppTheme.colors.hintPinkWhite,
                        )
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      actions: [
        DialogActionsButton(
            text: "Save",
            onPressed: onSave
        ),
        DialogActionsButton(
            text: "Close",
            onPressed: () { Navigator.of(context).pop(); }
        ),
      ],
    );
  }
}
