import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/DB_crud/users_info/get_user_info.dart';

void deleteTask(String taskState, String taskComplexity, String taskDocId, Function onChanged) async {
  if (taskState == "2") {
    Map<String, dynamic> userInfo = await getUserInfo();
    await FirebaseFirestore.instance.collection("users").doc(userInfo["docId"]).update({
      "tasks_points": (int.parse(userInfo["tasks_points"].toString()) + int.parse(taskComplexity)).toString()
    });
  }
  await FirebaseFirestore.instance.collection("tasks").doc(taskDocId).delete();
  onChanged();
}