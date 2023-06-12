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
            Container(
              width: UtilScreen().getWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 35),
                  ),
                  Text(
                    "Numerical",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Differentiation App",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 25, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: UtilScreen().getHeight(context) * 0.02,
            ),
            SizedBox(
              height: UtilScreen().getHeight(context) * 0.3,
              width: UtilScreen().getWidth(context) * 0.6,
              child: LottieBuilder.asset('assets/lottie_welcome.json'),
            ),
            SizedBox(
              height: UtilScreen().getHeight(context) * 0.05,
            ),
            SizedBox(
                width: UtilScreen().getWidth(context) * 0.8,
                child: Text(
                  "Get ready to compute derivatives with ease. Let's dive in!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w300),
                )),
            const Spacer(),
            Container(
              height: 50,
              width: UtilScreen().getWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors().appGreenThree),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const ComputationScreen())));
                  },
                  child: Text(
                    "GET STARTED",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: UtilScreen().getHeight(context) * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
