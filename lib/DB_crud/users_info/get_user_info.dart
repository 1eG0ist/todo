import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>> getUserInfo() async {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> taskData = {};
  await FirebaseFirestore.instance.collection('users')
      .where('email', isEqualTo: user?.email.toString())
      .get().then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      taskData = doc.data()! as Map<String, dynamic>;
      taskData["docId"] = doc.id.toString();
    }),
  });
  return taskData;
}