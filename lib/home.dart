import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();

  Future<String> callApi() async {
    Dio dio = Dio();
    var response = await dio.post("");
    return response.data;
  }

  saveToSharedPreferences(String shortenedUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lastUrl", shortenedUrl);
  }

  Future<String> getLastUrlFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lastUrl = prefs.getString("lastUrl") ?? "";
    return lastUrl;
  }

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
                height: 150,
                width: 350,
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0XFF22272C)),
                        onPressed: () {},
                        child: Text("Shorten"),
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
