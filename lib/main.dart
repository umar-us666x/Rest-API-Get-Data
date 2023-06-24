import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String body = "No Data";

  void getData() async {
    var myResponse = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users/3"),
    );

    Map<String, dynamic> data = jsonDecode(myResponse.body);

    setState(() {
      body = data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: getData,
          child: Icon(Icons.get_app),
        ),
        appBar: AppBar(
          title: Text("GET DATA USE REST API"),
        ),
        body: Center(
          child: Text(body),
        ),
      ),
    );
  }
}
