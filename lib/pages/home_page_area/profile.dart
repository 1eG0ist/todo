import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/dialogs/loading_indicator_dialog.dart';
import 'package:todo/theme/text_styles.dart';

import '../../theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  /*
  * TODO: for first time add data to hive, and update them when user send something to firebase
  *  it will delete 0.2 sec loading every time when user swap to any page when app have db request
  * */

  late String userDocID;
  late Map<String, dynamic> userInfo = {
    "avatar_number": 1,
    "email": "...",
    "first_name": "...",
    "last_name": "...",
    "age": "...",
  };
  late String userEmail;

  Future getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: user?.email.toString())
        .get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        userDocID = doc.id;
        setState(() {
          userInfo = doc.data()! as Map<String, dynamic>;
        });
      }),
    });
  }
  
  void updateUserAvatarNumber() async {
    await FirebaseFirestore.instance.collection("users").doc(userDocID).update({"avatar_number": userInfo["avatar_number"]});
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userInfo["email"] == "..." ?
    const LoadingIndicatorDialog()
        :
    // profile page variant
    Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.colors.purple,

        onPressed: () {FirebaseAuth.instance.signOut();},
        elevation: 0,
        child: Icon(Icons.logout, color: AppTheme.colors.pinkWhite),
      ),
      backgroundColor: AppTheme.colors.spacePurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // avatar
                Center(
                 child: Image(
                   image: AssetImage('assets/avatars/avatar_${userInfo["avatar_number"]}.png'), //${userInfo["avatar_number"]}
                   height: MediaQuery.of(context).size.width - 100,
                 ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {
                      setState(() {
                        userInfo["avatar_number"] -= 1;
                        if (userInfo["avatar_number"] <= 0) {
                          userInfo["avatar_number"] = 6;
                        }
                      });
                    }, icon: Icon(Icons.keyboard_double_arrow_left, color: AppTheme.colors.pinkWhite),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: updateUserAvatarNumber,
                      color: AppTheme.colors.purple,
                      child: Text("Save", style: mainTextStyle),
                    ),
                    IconButton(onPressed: () {
                      setState(() {
                        userInfo["avatar_number"] += 1;
                        if (userInfo["avatar_number"] >= 7) {
                          userInfo["avatar_number"] = 1;
                        }
                      });
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
                const SizedBox(height: 20),
                Text("Points", style: miniTextStyle),
                Text(userInfo["tasks_points"].toString(), style: mainTextStyle,),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
