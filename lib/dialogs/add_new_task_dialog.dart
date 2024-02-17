import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/theme/text_styles.dart';

import '../theme/app_theme.dart';
import '../theme/buttons/dialog_actions_button.dart';
import '../theme/text_fields/text_field_decorations/default_text_field_decoration.dart';

class AddNewTaskDialogBox extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController textController;
  final TextEditingController dateController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddNewTaskDialogBox({
    super.key,
    required this.titleController,
    required this.textController,
    required this.dateController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
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
                    controller: titleController,
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
                    controller: textController,
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
                    controller: dateController,
                    inputFormatters: [LengthLimitingTextInputFormatter(300)],
                    style: mainTextStyle,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.subtitles_outlined, color: AppTheme.colors.pinkWhite),
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
            onPressed: onCancel
        ),
      ],
    );
  }
}
