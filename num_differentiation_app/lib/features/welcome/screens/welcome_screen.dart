import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:num_differentiation_app/app/constants/app_colors.dart';
import 'package:num_differentiation_app/app/util/util_screen.dart';
import 'package:num_differentiation_app/features/computation/screens/computation_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                'assets/circle_welcome.svg',
                width: UtilScreen().getWidth(context) * 0.4,
                height: UtilScreen().getHeight(context) * 0.2,
              ),
            ),
            Text("Welcome to "),
            Text("Numerical"),
            Text("Differentiation App"),
            SizedBox(
              height: UtilScreen().getHeight(context) * 0.02,
            ),
            Container(
              height: UtilScreen().getHeight(context) * 0.3,
              width: UtilScreen().getWidth(context) * 0.6,
              child: LottieBuilder.asset('assets/lottie_welcome.json'),
            ),
            SizedBox(
              height: UtilScreen().getHeight(context) * 0.05,
            ),
            Container(
                width: UtilScreen().getWidth(context) * 0.8,
                child: Text(
                    "Get ready to compute derivatives with ease. Let's dive in!")),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ComputationScreen())));
                },
                child: Text("GET STARTED")),
            SizedBox(
              height: UtilScreen().getHeight(context) * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
