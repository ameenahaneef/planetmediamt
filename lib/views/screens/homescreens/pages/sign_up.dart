import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetmediamt/controllers/auth_controller.dart';
import 'package:planetmediamt/utils/constants.dart';
import 'package:planetmediamt/views/screens/homescreens/widgets/textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
      ),
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/[removal.ai]_1918348b-5988-4d07-a786-dc3ec31f6fe8-brunette-business-woman-with-wavy-long-hair-blue-eyes-stands-holding-notebook-hands.png',
            fit: BoxFit.cover,
          )),
          Positioned.fill(
              child: Container(
            color: Colors.black.withOpacity(0.5),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('SignUp',
                      style: TextStyle(color: textColor, fontSize: 40)),
                  const SizedBox(
                    height: 30,
                  ),
                  Formfield(
                    labelText: 'Username',
                    controller: usernameController,
                  ),
                  height10,
                  Formfield(labelText: 'Email id', controller: emailController),
                  const SizedBox(
                    height: 10,
                  ),
                  Formfield(
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  height20,
                  Obx(
                    () => ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            bool isSuccess = _authController.signUp(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                usernameController.text.trim()) as bool;
                            if (isSuccess) {
                              usernameController.clear();
                              emailController.clear();
                              passwordController.clear();
                              Get.back();
                            }
                          }
                        },
                        child: _authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Create Account')),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
