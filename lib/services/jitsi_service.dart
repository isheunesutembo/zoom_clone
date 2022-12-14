import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/services/auth_service.dart';
import 'package:zoom_clone/services/firestoreservice.dart';

class JitsiService {
  final FireStoreService fireStoreService=FireStoreService();
  final AuthService authService = AuthService();
  void createMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted,
      String userName = ""}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (userName.isEmpty) {
        name = authService.user.displayName!;
      } else {
        name = userName;
      }

      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = authService.user.email
        ..userAvatarURL = authService.user.photoURL // or .png

        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;
        fireStoreService.addMeetingsToHistory(roomName);

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      throw Exception(error);
    }
  }
}
