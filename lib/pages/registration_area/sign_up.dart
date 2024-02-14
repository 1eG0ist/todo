import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future showCustomDialog(Text text) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.red,
        content: text
      );
    });
  }

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

    bool _errorFlag = false;
    if (_firstNameController.text.trim() == "") {
      _errorFlag = true;
      showCustomDialog(
          Text("Please enter your name", style: mainTextStyle)
      );
    }
    else if (_lastNameController.text.trim() == "") {
      _errorFlag = true;
      showCustomDialog(
          Text("Please enter your surname", style: mainTextStyle)
      );
    }
    else if (_ageController.text.trim() == "") {
      _errorFlag = true;
      showCustomDialog(
          Text("Please enter your age", style: mainTextStyle)
      );
    }
    else if (int.parse(_ageController.text) > 120 || int.parse(_ageController.text) < 3) {
      _errorFlag = true;
      showCustomDialog(
          Text("I don't think that's your real age.", style: mainTextStyle)
      );
    }
    else if (_emailController.text.trim().length < 6 ||
        _emailController.text.trim().split("@").length == 1 ||
        _emailController.text.trim().split("@")[1].split(".").length == 1) {
      _errorFlag = true;
      showCustomDialog(
          Text("I don't think that's your real email.", style: mainTextStyle)
      );
    }
    else if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      _errorFlag = true;
      showCustomDialog(
          Text("Your password and confirm password not equals", style: mainTextStyle)
      );
    }
    else if (_passwordController.text.trim().length < 6) {
      _errorFlag = true;
      showCustomDialog(
          Text("Password password must be longer then 5 symbols", style: mainTextStyle)
      );
    }

    if (!_errorFlag) {
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

      if (FirebaseAuth.instance.currentUser != null) {
        setState(() {
        titleIcon = Icon(Icons.lock_open, color: Colors.greenAccent, size: 100,);
        });
      } else {
        setState(() {
          titleIcon = Icon(Icons.lock_outline, color: Colors.red, size: 100,);
        });
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
