import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text("Let's  shorten URL's!"),
            ),
            Container(
              child: Text("Image goes here"),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text("We will input our URL here"),
            ),
          ],
        ),
      ),
    );
  }
}
