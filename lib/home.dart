import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  var _shortenedUrl = "";
  var _lastShortenedUrl = "";
  bool isShorteningUrl = false;

  @override
  void initState() {
    super.initState();
    getLastUrlFromSharedPreferences();
  }

  Future<String> callApi(String url) async {
    Dio dio = Dio();
    var response = await dio.get("https://api.shrtco.de/v2/shorten?url=" + url);
    print(response);
    if (response.statusCode != 201) {
      return Future.error("Failed to shorten the link!");
    }
    return response.data["result"]["full_short_link"];
  }

  saveToSharedPreferences(String shortenedUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lastUrl", shortenedUrl);
  }

  getLastUrlFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lastUrl = prefs.getString("lastUrl") ?? "";
    setState(() {
      _lastShortenedUrl = lastUrl;
    });
  }

  _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

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
                child: InkWell(
                  onTap: () {
                    _launchURL(_lastShortenedUrl);
                  },
                  child: Text(_shortenedUrl),
                ),
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
                      !isShorteningUrl
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0XFF22272C)),
                              onPressed: () async {
                                setState(() {
                                  isShorteningUrl = true;
                                });
                                var inputUrl = textController.text;
                                print(inputUrl);
                                try {
                                  var shortenedUrl = await callApi(inputUrl);
                                  await saveToSharedPreferences(shortenedUrl);
                                  setState(() {
                                    _shortenedUrl = shortenedUrl;
                                    _lastShortenedUrl = shortenedUrl;
                                    isShorteningUrl = false;
                                  });
                                } catch (e) {
                                  setState(() {
                                    isShorteningUrl = false;
                                  });
                                }
                              },
                              child: Text("Shorten"),
                            )
                          : CircularProgressIndicator(
                              color: Color(0XFF22272C),
                            ),
                    ],
                  ),
                ),
              ),
              _lastShortenedUrl != ""
                  ? Container(
                      child: InkWell(
                        onTap: () {
                          _launchURL(_lastShortenedUrl);
                        },
                        child: Text(
                            "Your last shortened url was $_lastShortenedUrl"),
                      ),
                    )
                  : Container(
                      child: Text("You do not have any links saved!"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
