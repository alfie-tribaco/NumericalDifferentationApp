import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:num_differentiation_app/features/welcome/screens/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            headlineSmall: GoogleFonts.museoModerno()
                .copyWith(fontWeight: FontWeight.bold)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
