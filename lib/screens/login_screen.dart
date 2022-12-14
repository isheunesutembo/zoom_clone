import 'package:flutter/material.dart';
import 'package:zoom_clone/services/auth_service.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final AuthService authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Start or Join Meeting",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Image.asset("assets/images/onboarding.jpg"),
          ),
           CustomButton(text: "LogIn", onPressed:()async{
            bool res=await authService.signInWithGoogle(context);

            if(res){
              Navigator.pushNamed(context, '/home');
            }
           })
        ]),
      ),
    );
  }
}
