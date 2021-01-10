import 'package:cloud_firestore/cloud_firestore.dart';

class Storage {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final collection = 'testing';

  static Stream<dynamic> getStream() {
    return firestore.collection(collection).snapshots();
  }

  static void deleteAlarm(String id) {
    firestore
        .collection(collection)
        .doc(id)
        .delete()
        .then((value) => print("Alarm deleted"))
        .catchError((error) => print("failed to delete alarm"));
  }

  static Future<String> addAlarm(alarm) async {
    return await firestore.collection(collection).add(alarm).then((value) {
      print("Alarm added successfully");
      return value.id;
    });
  }

  static Future<DocumentSnapshot> getAlarmDetails(String id) async {
    return await firestore.collection(collection).doc(id).get();
  }

  static void updateAlarm(String id, alarm) async {
    await firestore.collection(collection).doc(id).update(alarm);
  }
}
