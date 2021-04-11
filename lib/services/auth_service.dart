import 'dart:convert';

import 'package:chatapp/global/envitoroments.dart';
import 'package:chatapp/models/login_response.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/envitoroments.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  //Getters del token de forma statica
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
    final data = {'email': email.trim(), 'password': password.trim()};

    final url = Uri.parse('${Enviroment.apiUrl}/login');

    this.autenticando = true;

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      // guardar token en lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    }
    return false;
  }

  Future register(String nombre, String email, String password) async {
    final data = {
      'nombre': nombre.trim(),
      'email': email.trim(),
      'password': password.trim()
    };

    final url = Uri.parse('${Enviroment.apiUrl}/login/new');

    this.autenticando = true;

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }

    final respBody = jsonDecode(resp.body);
    return respBody['msg'];
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    final url = Uri.parse('${Enviroment.apiUrl}/login/renew');
    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }

    this.logout();
    return false;
  }

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
