import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/services/jitsi_service.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({super.key});

  @override
  State<CreateMeetingScreen> createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  final JitsiService jitsi_service = JitsiService();
  createNewMeeting() {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    jitsi_service.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  @override
  void dispose() {
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/videocallscreen');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeMeetingButton(
                onPressed: createNewMeeting,
                icon: Icons.videocam,
                text: "New Meeting"),
            HomeMeetingButton(
                onPressed: () => joinMeeting(context),
                icon: Icons.add_box_rounded,
                text: "Join Meeting"),
            HomeMeetingButton(
                onPressed: () {},
                icon: Icons.calendar_today,
                text: "Schedule Meeting"),
            Expanded(
              child: HomeMeetingButton(
                  onPressed: () {},
                  icon: Icons.arrow_upward_rounded,
                  text: "Share Screen"),
            )
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meeting with just a click !',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
