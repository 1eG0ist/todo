import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../dialogs/dialogs.dart';
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

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Icon titleIcon = Icon(Icons.lock_outline, color: AppTheme.colors.pinkWhite, size: 100,);

  // Future showCustomErrDialog(Text text) {
  //   return showDialog(context: context, builder: (context) {
  //     return AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //       backgroundColor: Colors.red,
  //       content: text
  //     );
  //   });
  // }

  Future addUserDetails(String firstName, String lastName, int age, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'email': email,
      'avatar_number': 1,
    });
  }

  Future signUp() async {

    if (_firstNameController.text.trim() == "") {
      showCustomErrDialog(
          "Please enter your name",
          context
      );
    }
    else if (_lastNameController.text.trim() == "") {
      showCustomErrDialog(
          "Please enter your surname",
          context
      );
    }
    else if (_ageController.text.trim() == "") {
      showCustomErrDialog(
          "Please enter your age",
          context
      );
    }
    else if (int.parse(_ageController.text) > 120 || int.parse(_ageController.text) < 3) {
      showCustomErrDialog(
          "I don't think that's your real age.",
          context
      );
    }
    else if (_emailController.text.trim().length < 6 ||
        _emailController.text.trim().split("@").length == 1 ||
        _emailController.text.trim().split("@")[1].split(".").length == 1) {
      showCustomErrDialog(
          "I don't think that's your real email.",
          context
      );
    }
    else if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      showCustomErrDialog(
          "Your password and confirm password not equals",
          context
      );
    }
    else if (_passwordController.text.trim().length < 6) {
      showCustomErrDialog(
          "Password password must be longer then 5 symbols",
          context
      );
    } else {
      try {
        showLoadingIndicator(context);
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()
        );

        // add user details
        addUserDetails(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            int.parse(_ageController.text.trim()),
            _emailController.text.trim()
        );

        setState(() {
          titleIcon = Icon(Icons.lock_open, color: Colors.greenAccent, size: 100,);
        });
        Navigator.of(context).pop(); // hide loading indicator
        Navigator.of(context).pop(); // auto close sign in page when user created
      } catch (e) {
        Navigator.of(context).pop();
        setState(() {
          titleIcon = Icon(Icons.lock_outline, color: Colors.red, size: 100,);
        });
        if (e is FirebaseAuthException) {
          if (e.code == "email-already-in-use") {
            showCustomErrDialog(
                "This email already used! Try to sign in.",
                context
            );
          }
        } else {
          print("Other Error: $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppTheme.colors.pinkWhite,
          ),
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
                  const SizedBox(height: 50),
                  // first name text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: defaultBoxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
                            controller: _firstNameController,
                            inputFormatters: [LengthLimitingTextInputFormatter(50)],
                            style: mainTextStyle,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.connect_without_contact, color: AppTheme.colors.pinkWhite),
                                border: InputBorder.none,
                                hintText: "First name",
                                hintStyle: TextStyle(
                                  color: AppTheme.colors.hintPinkWhite,
                                )
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  // last name text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: defaultBoxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
                            controller: _lastNameController,
                            inputFormatters: [LengthLimitingTextInputFormatter(50)],
                            style: mainTextStyle,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.connect_without_contact, color: AppTheme.colors.pinkWhite),
                                border: InputBorder.none,
                                hintText: "Last name",
                                hintStyle: TextStyle(
                                  color: AppTheme.colors.hintPinkWhite,
                                )
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  // age text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: defaultBoxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
                            controller: _ageController,
                            inputFormatters: [LengthLimitingTextInputFormatter(50)],
                            style: mainTextStyle,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.child_care, color: AppTheme.colors.pinkWhite),
                                border: InputBorder.none,
                                hintText: "Age",
                                hintStyle: TextStyle(
                                  color: AppTheme.colors.hintPinkWhite,
                                )
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
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
