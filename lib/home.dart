import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Let's  shorten URL's!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                child: Text("Image goes here"),
              ),
              Container(
                height: 125,
                width: 300,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.link),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Input your URL to shorten",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: textController,
                          style: TextStyle(color: Colors.black),
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'http://'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text("The last url shortened was: "),
              )
            ],
          ),
        ),
      ),
    );
  }
}
