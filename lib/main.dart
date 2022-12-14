import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/home_screen.dart';
import 'package:zoom_clone/screens/login_screen.dart';
import 'package:zoom_clone/screens/video_call_screen.dart';
import 'package:zoom_clone/services/auth_service.dart';
import 'package:zoom_clone/utils/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),

      routes: {
        '/login':(context) =>LogInScreen() ,
        '/home':(context)=>HomeScreen(),
        '/videocallscreen':(context)=>VideoCallScreen()
      },
      
        
      home: StreamBuilder(
        stream: AuthService().authChanges,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: 
            CircularProgressIndicator(),);
          }

          if(snapshot.hasData){
            return HomeScreen();
          }

          return LogInScreen();
        },
      )
    );
  }
}

