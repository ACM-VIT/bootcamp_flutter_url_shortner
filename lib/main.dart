import 'package:flutter/material.dart';
import 'package:flutter_url_shortner/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter URL Shortner',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFF22272C),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context)
              .textTheme
              .apply(displayColor: Colors.white, bodyColor: Colors.white),
        ),
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
