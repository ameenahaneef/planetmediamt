import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetmediamt/controllers/auth_controller.dart';
import 'package:planetmediamt/firebase_options.dart';
import 'package:planetmediamt/views/screens/emp_details/pages/employee.dart';
import 'package:planetmediamt/views/screens/homescreens/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(AuthController(prefs));

  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(isLoggedIn: user != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn ? EmployeeScreen() : const SplashScreen(),
    );
  }
}
