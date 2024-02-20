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
  final TextEditingController complexityController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddNewTaskDialogBox({
    super.key,
    required this.titleController,
    required this.textController,
    required this.dateController,
    required this.complexityController,
    required this.onSave,
    required this.onCancel,
  });

  void minusComplexity() {
    int n = int.parse(complexityController.text.trim());
    if (n == 1) {
      complexityController.text = "3";
    } else {
      complexityController.text = (n-1).toString();
    }
  }

  void plusComplexity() {
    int n = int.parse(complexityController.text.trim());
    if (n == 3) {
      complexityController.text = "1";
    } else {
      complexityController.text = (n+1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      backgroundColor: AppTheme.colors.darkPurple,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: SafeArea(
        child: SingleChildScrollView(
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
              const SizedBox(height: 10),

              // choose complexity of a task from 1 to 3
              Row(
                children: [
                  Text("Complexity: ", style: mainTextStyle),
                  IconButton(
                      onPressed: minusComplexity,
                      icon: Icon(Icons.keyboard_arrow_left_outlined,
                          color: AppTheme.colors.darkPink
                      )
                  ),

                  // Text(complexityController.text.trim(), style: mainTextStyle),
                  SizedBox(
                      width: 30,
                      child: TextField(
                        controller: complexityController,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        style: mainTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: "",
                          border: InputBorder.none,
                        ),
                      )
                  ),

                  IconButton(
                      onPressed: plusComplexity,
                      icon: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: AppTheme.colors.darkPink
                      )
                  ),
                ],
              )
            ],
          ),
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
