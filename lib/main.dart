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
  List data = [];

  Future getData() async {
    await Future.delayed(Duration(seconds: 3));
    var myResponse = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    var dataRespon = jsonDecode(myResponse.body) as List;
    if (myResponse.statusCode == 200) {
      data = dataRespon;
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: getData,
        //   child: Icon(Icons.get_app),
        // ),
        appBar: AppBar(
          title: Text("GET DATA - REST API"),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshoot) {
            if (snapshoot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataUser = data[index];
                  return ListTile(
                    title: Text(
                      dataUser['name'],
                    ),
                    leading: CircleAvatar(backgroundColor: Colors.grey),
                    subtitle: Text(dataUser['email']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
