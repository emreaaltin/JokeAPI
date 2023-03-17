import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ders',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

Future<String> fetchJoke() async {
  final response = await http
      .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
  if (response.statusCode == 200) {
    return json.decode(response.body)['setup'] +
        '\n\n' +
        json.decode(response.body)['punchline'];
  } else {
    throw Exception('Failed to load joke');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokeAPI"),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchJoke(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.requireData);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
