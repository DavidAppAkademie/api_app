import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // State
  String _quote = '';
  String _author = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _quote,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                _author,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        // Ladezustand auf true setzen
                        setState(() {
                          _isLoading = true;
                        });

                        // API Anfrage
                        final response = await http.get(
                          Uri.parse('https://zenquotes.io/api/random'),
                        );

                        // JSON String
                        String myJsonStr = response.body;

                        // Umwandlung des JSON String in eine Liste von Maps
                        final List myList = jsonDecode(myJsonStr);

                        // Ausgabe
                        setState(() {
                          _quote = myList[0]["q"];
                          _author = myList[0]["a"];
                          _isLoading = false;
                        });
                      },
                child: Text("Zitat laden"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
