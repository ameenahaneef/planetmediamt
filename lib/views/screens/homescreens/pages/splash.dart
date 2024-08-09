import 'package:flutter/material.dart';
import 'package:planetmediamt/utils/constants.dart';
import 'package:planetmediamt/views/screens/homescreens/pages/home_splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
        return const HomeSplash();
      }), (route) => false);
    });
    return Scaffold(
      backgroundColor: bgColor,
      body:  Center(child: Text('CrewHub',style: stylex)),

    );
  }
}