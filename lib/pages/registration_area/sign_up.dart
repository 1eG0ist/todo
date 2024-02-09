import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_theme.dart';
import '../../theme/buttons/container_button_decorations.dart';
import '../../theme/text_fields/text_field_decorations/default_text_field_decoration.dart';
import '../../theme/text_styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPasswordErrorVisible = false;
  final _passwordConfirmPasswordError = const Text(
      "Your password and confirm password not equals",
      style: TextStyle(color: Colors.red, fontFamily: "Ubuntu", fontSize: 18),
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );
    } else {
      setState(() {
        isPasswordErrorVisible = !isPasswordErrorVisible;
      });
    }

    if (FirebaseAuth.instance.currentUser != null ) {
      setState(() {
        titleIcon = Icon(Icons.lock_open, color: Colors.greenAccent, size: 100,);
        isPasswordErrorVisible = false;
      });
    } else {
      titleIcon = Icon(Icons.lock_outline, color: Colors.red, size: 100,);
    }
  }

  // default icon state
  Icon titleIcon = Icon(Icons.lock_outline, color: AppTheme.colors.pinkWhite, size: 100,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
        appBar: AppBar(
          title: Text("Sign up", style: bigTextStyle),
          centerTitle: true,
          backgroundColor: AppTheme.colors.darkPurple,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  titleIcon,
                  Text("H E L L O", style: bigTextStyle),
                  const SizedBox(height: 25),
                  isPasswordErrorVisible ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _passwordConfirmPasswordError,
                  ) : Container(),
                  const SizedBox(height: 25),
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
                  const SizedBox(height: 10,),
                  // password text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: defaultBoxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
                            controller: _passwordController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            obscureText: true,
                            style: mainTextStyle,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.fingerprint, color: AppTheme.colors.pinkWhite),
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: AppTheme.colors.hintPinkWhite,
                                )
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 10),
                  // confirm password text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: defaultBoxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
                            controller: _confirmPasswordController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            obscureText: true,
                            style: mainTextStyle,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.fingerprint_rounded, color: AppTheme.colors.pinkWhite),
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  color: AppTheme.colors.hintPinkWhite,
                                )
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 25,),
                  // sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: mainContainerButtonDecoration,
                        child: Center(
                          child: Text("Sign up", style: mainTextStyle),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
