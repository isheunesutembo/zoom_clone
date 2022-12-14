import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/create_meeting_screen.dart';
import 'package:zoom_clone/screens/history_meeting_screen.dart';
import 'package:zoom_clone/services/auth_service.dart';
import 'package:zoom_clone/utils/color.dart';
import 'package:zoom_clone/widgets/custom_button.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  int page_index = 0;
  onPageChange(int page) {
    setState(() {
      page_index = page;
    });
  }

  List<Widget> pages = [
    CreateMeetingScreen(),
    const HistoryMeetingScreen(),
    const Text("Contacts"),
    CustomButton(text: "SignOut", onPressed: () => AuthService().signOut())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text("Meet & Chat"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onPageChange,
          backgroundColor: backgroundColor,
          selectedItemColor: Colors.white,
          currentIndex: page_index,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.comment_bank,
                ),
                label: 'Meet & Chat'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_clock,
                ),
                label: 'Meetings'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings'),
          ]),
      body: pages[page_index],
    );
  }
}
