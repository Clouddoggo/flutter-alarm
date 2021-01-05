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

  static void addAlarm(alarm) {
    firestore
        .collection(collection)
        .add(alarm)
        .then((value) => print("Alarm added"))
        .catchError((error) => print("failed to add alarm"));
  }
}
