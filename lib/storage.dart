import 'package:cloud_firestore/cloud_firestore.dart';

class Storage {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final collection = 'testadd';

  static Stream<dynamic> getStream() {
    return firestore.collection(collection).snapshots();
  }

  static void deleteAlarm(String id) {
    firestore.collection(collection).doc(id).delete();
  }

  static void addAlarm(alarm) {
    firestore.collection(collection).add(alarm);
  }
}
