import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream get meetingHistory=> firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("meeting").snapshots();
  void addMeetingsToHistory(String meetingName) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("meeting")
          .add({
            'meetingName':meetingName,
            'createdAt':DateTime.now()
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
