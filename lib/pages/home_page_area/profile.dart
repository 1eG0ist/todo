import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/DB_crud/users_info/get_user_info.dart';
import 'package:todo/main.dart';
import 'package:todo/pages/registration_area/routes.dart';
import 'package:todo/theme/text_styles.dart';

import '../../theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late FirebaseAuth _auth;
  late Stream<User?> _authStateChanges;
  late String userDocID;
  late Map<String, dynamic> userInfo = {
    "email": "...",
    "first_name": "...",
    "last_name": "...",
    "age": "...",
  };
  late String userEmail;

  // void getUserEmail() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   if (user != null) {
  //     userEmail = user.email.toString();
  //   }
  // }

  Future getUserInfo() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) async {
      if (user != null) {
        await FirebaseFirestore.instance.collection('users')
            .where('email', isEqualTo: user.email.toString())
            .get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            setState(() {
              userInfo = doc.data()! as Map<String, dynamic>;
            });
            print("Hello!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
            print(doc.data());
          }),
        });
      }
    });

    // if (user != null) {
    //   await FirebaseFirestore.instance.collection('users')
    //       .where('email', isEqualTo: user.email.toString())
    //       .get().then((QuerySnapshot querySnapshot) => {
    //     querySnapshot.docs.forEach((doc) {
    //       userInfo = doc.data()! as Map<String, dynamic>;
    //       print("Hello!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    //       print(doc.data());
    //     }),
    //   });
    // }
  }

  // Future getUserInfo() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   if (user != null) {
  //     await FirebaseFirestore.instance.collection('users')
  //       .where('email', isEqualTo: user.email.toString())
  //       .get().then((QuerySnapshot querySnapshot) => {
  //         querySnapshot.docs.forEach((doc) {
  //           userInfo = doc.data()! as Map<String, dynamic>;
  //           print("Hello!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
  //           print(doc.data());
  //         }),
  //     });
  //   }
  // }

  @override
  void initState() {
    print("lol");
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // avatar
              Center(
               child: Image(
                 image: AssetImage('assets/avatars/avatar_1.png'), //${userInfo["avatar_number"]}
                 height: MediaQuery.of(context).size.width - 100,
               ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {

                  }, icon: Icon(Icons.keyboard_double_arrow_left, color: AppTheme.colors.pinkWhite),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {

                    },
                    color: AppTheme.colors.purple,
                    child: Text("Change avatar", style: mainTextStyle),
                  ),
                  IconButton(onPressed: () {

                  }, icon: Icon(Icons.keyboard_double_arrow_right, color: AppTheme.colors.pinkWhite)
                  ),
                ],
              ),
              Divider(color: AppTheme.colors.white,),
              const SizedBox(height: 15),
              Text("Email", style: miniTextStyle),
              Text(userInfo["email"].toString(), style: mainTextStyle,),
              const SizedBox(height: 20),
              Text("Name", style: miniTextStyle),
              Text(userInfo["first_name"].toString(), style: mainTextStyle,),
              const SizedBox(height: 20),
              Text("Surname", style: miniTextStyle),
              Text(userInfo["last_name"].toString(), style: mainTextStyle,),
              const SizedBox(height: 20),
              Text("Age", style: miniTextStyle),
              Text(userInfo["age"].toString(), style: mainTextStyle,),
            ],
          ),
        ),
      ),
    );
  }
}
