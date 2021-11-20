


import 'package:idaipqroo/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class UserReportsService with ChangeNotifier {

List<String> categories = [
        "Vialidad",
        "Salud Pública",
        "Buena vecindad",
        "Atención ciudadana",
        "Otro"
  ];
  String _selectedCategory= 'Vialidad';


  List<Status> status = [
    Status('En proceso', 'PROCESS'),
    Status('Finalizado', 'FINALIZED'),
    Status('Cancelado', 'CANCELLED'),
  ];
  String _selectedStatus = 'PROCESS';

  bool isLoading = true;

  List<Service> services = [];

  final storage = new FlutterSecureStorage();

  UserReportsService() {
    getUserServicesByCategory( _selectedCategory, _selectedStatus );
  }

  List<Service> get getServices => services;

  String get selectedCategory => _selectedCategory;
  set selectedCategory( String valor ) {
    _selectedCategory = valor;

    isLoading = true;
    
    getUserServicesByCategory( valor, _selectedStatus );

    notifyListeners();
  }

  String get selectedStatus => _selectedStatus;
  set selectedStatus( String valor ) {
    _selectedStatus = valor;

    isLoading = true;
    getUserServicesByCategory( _selectedCategory, valor );
    notifyListeners();
  }




  getUserServicesByCategory( String category, String status ) async {

    final url =  Uri.parse( '${ Environment.apiUrl }/service/user/$status/$category' );
    final accessToken = await storage.read(key: 'accessToken');
    print( '$category' );
    print( '$status' );

    final resp = await http.get( url ,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    final servicesResponse = servicesResponseFromJson( resp.body );

    services.clear();
    services.addAll( servicesResponse.services );

    
    isLoading = false;

    notifyListeners();
  }

}