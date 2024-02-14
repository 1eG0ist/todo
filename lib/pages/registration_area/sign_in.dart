import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/dialogs.dart';
import 'package:todo/main.dart';
import 'package:todo/theme/buttons/container_button_decorations.dart';

import '../../theme/app_theme.dart';
import '../../theme/text_fields/text_field_decorations/default_text_field_decoration.dart';
import '../../theme/text_styles.dart';
import '../home_page_area/home.dart';
import 'forgot_pw_page.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // default icon state
  Icon titleIcon = Icon(Icons.lock_outline, color: AppTheme.colors.pinkWhite, size: 100,);

  /*
  * TODO hide sign in page when auth accessed
  * */
  Future signIn() async {
    try {
      bool emailExists = false;
      await FirebaseFirestore.instance.collection('users')
          .where('email', isEqualTo: _emailController.text.trim())
          .get().then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) {
          print("Zashel suda!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          emailExists = true;
        }),
      });
      if (emailExists) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()
        );
      } else {
        showCustomErrDialog(
            Text("This email has not been registered yet! Try to sign up.", style: mainTextStyle),
            context
        );
      }


      // if all is okay
      if (FirebaseAuth.instance.currentUser != null) {
        setState(() {
          titleIcon = Icon(Icons.lock_open, color: Colors.greenAccent, size: 100,);
        });
      } else {
        titleIcon = Icon(Icons.lock_outline, color: Colors.red, size: 100,);
        showCustomErrDialog(
            Text("Something went wrong", style: mainTextStyle),
            context
        );
      }
      Navigator.of(context).pop(); // auto close sign in page when user registered
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "invalid-email") {
          showCustomErrDialog(
              Text("The email field is filled in incorrectly! Try again.", style: mainTextStyle,),
              context
          );
        }
      } else {
        print("Other Error: $e");
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.colors.pinkWhite,
        ),
        title: Text("Sign in", style: bigTextStyle),
        centerTitle: true,
        backgroundColor: AppTheme.colors.darkPurple,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleIcon,
                Text("H E L L O", style: bigTextStyle),
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
                
                const SizedBox(height: 5),

                // Forgot password button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: const Text("Forgot password?", style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold
                          )
                        )
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: mainContainerButtonDecoration,
                      child: Center(
                        child: Text("Sign in", style: mainTextStyle),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}
