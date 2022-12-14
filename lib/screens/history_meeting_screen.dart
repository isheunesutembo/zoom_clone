import 'package:flutter/material.dart';
import 'package:zoom_clone/services/firestoreservice.dart';
import 'package:intl/intl.dart';

class HistoryMeetingScreen extends StatefulWidget {
  const HistoryMeetingScreen({super.key});

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  FireStoreService fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fireStoreService.meetingHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(
                        "Room Name ${(snapshot.data! as dynamic).docs[index]['meetingName']}"),
                        subtitle: Text("Joined On ${DateFormat.yMMMd((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}")
                  ),
                  
                  );
        });
  }
}
