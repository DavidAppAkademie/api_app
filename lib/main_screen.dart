import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () async {
            final response = await http.get(
              Uri.parse('https://zenquotes.io/api/random'),
            );

            String myJsonStr = response.body;

            final List myList = jsonDecode(myJsonStr);
            debugPrint("${myList[0]["q"]} ---> ${myList[0]["a"]}");
          },
          child: Text("Test"),
        ),
      ),
    );
  }
}
