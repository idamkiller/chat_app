import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/register_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  User user;
  bool _isLogin = false;
  bool _isRegister = false;

  final _storage = new FlutterSecureStorage();

  bool get isLogin => this._isLogin;
  set isLogin(bool data) {
    this._isLogin = data;
    notifyListeners();
  }

  bool get isRegister => this._isRegister;
  set isRegister(bool data) {
    this._isRegister = data;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.isLogin = true;
    final data = {
      'email': email,
      'password': password,
    };
    final url = Uri.parse('${Environment.apiURL}/login');
    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    this.isLogin = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    this.isRegister = true;
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };
    final url = Uri.parse('${Environment.apiURL}/login/new');
    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    this.isRegister = false;

    if (resp.statusCode == 200) {
      final registerResponse = registerResponseFromJson(resp.body);
      this.user = registerResponse.user;
      await this._saveToken(registerResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    print(token);

    final url = Uri.parse('${Environment.apiURL}/login/renew');
    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this._logout(token);
      return false;
    }
  }

  Future _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future _logout(String token) async {
    await _storage.delete(key: 'token');
  }
}
