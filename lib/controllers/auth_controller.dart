import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetmediamt/views/screens/emp_details/pages/employee.dart';
import 'package:planetmediamt/views/screens/homescreens/pages/login_screen.dart';
import 'package:planetmediamt/views/screens/homescreens/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  final SharedPreferences _prefs;
  AuthController(this._prefs);
  Future<void> signUp(String email, String password, String username) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({'username': username, 'email': email});

      if (userCredential.user != null) {
        await _prefs.setString('email', email);
        await _prefs.setString('password', password);
        Get.snackbar('Success', 'Account created successfully!',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await _prefs.setString('email', email);
        await _prefs.setString('password', password);
        Get.snackbar('Success', 'Logged in successfully!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
        Get.to(EmployeeScreen());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _prefs.remove('email');
    await _prefs.remove('password');
    await _auth.signOut();
    Get.offAll(const LoginScreen());
  }

  void checkLoginStatus() async {
    final email = _prefs.getString('email');
    final password = _prefs.getString('password');

    if (email != null && password != null) {
      Get.to(EmployeeScreen());
    } else {
      Get.to(const SplashScreen());
    }
  }
}
