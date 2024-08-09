import 'package:flutter/material.dart';
import 'package:planetmediamt/utils/constants.dart';
import 'package:planetmediamt/views/screens/homescreens/pages/login_screen.dart';

class HomeSplash extends StatelessWidget {
  const HomeSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Image(
              image: AssetImage(
                  'assets/[removal.ai]_1918348b-5988-4d07-a786-dc3ec31f6fe8-brunette-business-woman-with-wavy-long-hair-blue-eyes-stands-holding-notebook-hands.png'),
              height: 400,
            ),
            height20,
            const Center(
                child: Text(
              'Empower your team, and \nthey will empower your\n            business.',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
            height20,
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: textColor)),
                child: Text(
                  'Get Started',
                  style: TextStyle(color: textColor),
                ))
          ],
        ));
  }
}
