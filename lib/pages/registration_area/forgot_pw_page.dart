import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/theme/text_styles.dart';

import '../../theme/app_theme.dart';
import '../../theme/text_fields/text_field_decorations/default_text_field_decoration.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.green,
          content: Text("Password reset link sent! Check your email", style: mainTextStyle),
        );
      });
    } on FirebaseAuthException catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.red,
          content: Text(e.message.toString(), style: mainTextStyle),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.colors.pinkWhite,
        ),
        backgroundColor: AppTheme.colors.darkPurple,
      ),
      backgroundColor: AppTheme.colors.spacePurple,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Enter your email and we will send you a password reset link", style: bigTextStyle),
                ),
                const SizedBox(height: 50),

                // email text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      decoration: defaultBoxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          controller: _emailController,
                          inputFormatters: [LengthLimitingTextInputFormatter(50)],
                          style: mainTextStyle,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email, color: AppTheme.colors.pinkWhite),
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: AppTheme.colors.hintPinkWhite,
                              )
                          ),
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: passwordReset,
                  color: AppTheme.colors.purple,
                  child: Text("Reset Password", style: mainTextStyle),
                )
              ],
            )
          )
        )
      )
    );
  }
}
