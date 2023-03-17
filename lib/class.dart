import 'package:http/http.dart' as http;
import 'dart:convert';

class Joke {
  String? category;
  String? type;
  String? setup;
  String? delivery;
  String? joke;

  Joke({this.category, this.type, this.setup, this.delivery, this.joke});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      category: json['category'],
      type: json['type'],
      setup: json['setup'],
      delivery: json['delivery'],
      joke: json['joke'],
    );
  }
}

Future<Joke> fetchJoke() async {
  final response =
      await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single'));

  if (response.statusCode == 200) {
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load joke');
  }
}
