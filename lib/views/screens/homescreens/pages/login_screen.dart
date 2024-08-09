import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:planetmediamt/controllers/auth_controller.dart';
import 'package:planetmediamt/utils/constants.dart';
import 'package:planetmediamt/views/screens/homescreens/pages/sign_up.dart';
import 'package:planetmediamt/views/screens/homescreens/widgets/textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final TextEditingController emailidController = TextEditingController();
    final TextEditingController passwordiController = TextEditingController();
    return Scaffold(
      backgroundColor: bgColor,
      body: LayoutBuilder(builder: (context, constraints) {
        bool isWeb = constraints.maxWidth > 600;
        return Padding(
          padding: EdgeInsets.all(isWeb ? 40.0 : 20.0),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isWeb ? 600 : double.infinity),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Formfield(
                      labelText: 'Email id', controller: emailidController),
                  height20,
                  Formfield(
                    labelText: 'password',
                    controller: passwordiController,
                    obscureText: true,
                  ),
                  height10,
                  Obx(() => ElevatedButton(
                      onPressed: () {
                        if (emailidController.text.isNotEmpty &&
                            passwordiController.text.isNotEmpty) {
                          authController.signIn(emailidController.text.trim(),
                              passwordiController.text.trim());
                        } else {
                          Get.snackbar('Error', 'Please fill in all fields',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:textColor);
                        }
                      },
                      child: authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Login'))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have Account?',
                        style: TextStyle(color: textColor),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return SignUp();
                            }));
                          },
                          child: const Text('SignUp'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
