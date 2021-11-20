


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';



class AuthService with ChangeNotifier {

  late User user;
  bool _isAuthenticating = false;
  final _storage = new FlutterSecureStorage();

  bool get isAuthenticating => _isAuthenticating;

  set isAuthenticating( bool value ) {
    _isAuthenticating = value;
    notifyListeners();
  }

  /* Getters del token de forma estática */
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'accessToken');
    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'accessToken');
  }



  Future<bool> login( String email, String password ) async {

    isAuthenticating = true;

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post( Uri.parse( '${ Environment.apiUrl }/auth/login'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    print( resp.body );

    this.isAuthenticating = false;
    
    if ( resp.statusCode != 200 ){
      return false;
    } 

    final loginResponse = loginResponseFromJson( resp.body );
    user = loginResponse.user;

    /* Guardar token en lugar seguro */
    await _guardarToken(loginResponse.accessToken);

    return true;

  }





   Future register( String name, String email, String password ) async {

    isAuthenticating = true;

    final data = {
      'name': name,
      'email': email,
      'password': password
    };

    final resp = await http.post( Uri.parse( '${ Environment.apiUrl }/auth/register'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    print( resp.body );

    isAuthenticating = false;
    
    if ( resp.statusCode != 201 ){
      final respBody = jsonDecode(resp.body);
      return respBody['message'];
    } 

    final loginResponse = loginResponseFromJson( resp.body );
    user = loginResponse.user;

    /* Guardar token en lugar seguro */
    await _guardarToken(loginResponse.accessToken);
    
    return true;

  }


  Future<bool> isLoggedIn() async {

    var token = await _storage.read(key: 'accessToken');

    /* Si no hay token es un null */
    print( token );
    

    final resp = await http.get( Uri.parse( '${ Environment.apiUrl }/auth/renew'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    print( resp.body );

    if ( resp.statusCode != 200 ){
      logout();
      return false;
    } 

    final loginResponse = loginResponseFromJson( resp.body );
    user = loginResponse.user;

    /* Guardar token en lugar seguro */
    await _guardarToken(loginResponse.accessToken);

    return true;

  }



  Future _guardarToken( String token ) async{
    return await _storage.write(key: 'accessToken', value: token);
  }


  Future logout() async {
    await _storage.delete(key: 'accessToken');
  }

}