import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AuthRepository {

final uri=Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/users/login');

Future<void> login(String email, String password) async {
  final response = await http.post(
    uri, headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email':'sultan', 'password':'123'
    })
  );
  if (response.statusCode == 200) {
        print("Login successful");
        final cookie = response.headers['set-cookie'];
        if (cookie != null) {
          await saveCookie(cookie);
        }
      } else {
        print(response.statusCode);
        print("Login failed: ${response.body}");
      }
    } 

  Future<void> login1(String email, String password) async {
  final uri = Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/users/login');

  final response = await http.post(
    uri,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print("Login successful");
    print("Response: ${response.body}");

    final cookie = response.headers['set-cookie'];
    if (cookie != null) {
      await saveCookie(cookie);
      print("Cookie saved: $cookie");
    } else {
      print("No cookie received");
    }
  } else {
    print("Login failed: ${response.body}");
  }
}



     Future<void> saveCookie(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookie', cookie);
    print("yay got");
  }
}

