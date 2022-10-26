import 'package:flutter/material.dart';
import 'package:flutter_specialist/pages/splash_screen_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal, textTheme: GoogleFonts.robotoTextTheme()),
      home: const SplashScreen(),
    );
  }
}
