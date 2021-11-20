import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:http/http.dart' as http;


class ReportsService with ChangeNotifier {

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


  List<Service> services = [];

  late Report selectedReport;
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;


  final storage = new FlutterSecureStorage();
      
  ReportsService() {
    getServicesByCategory( _selectedCategory, _selectedStatus );
  }



  String get selectedCategory => _selectedCategory;
  set selectedCategory( String valor ) {
    _selectedCategory = valor;

    isLoading = true;
    
    getServicesByCategory( valor, _selectedStatus );

    notifyListeners();
  }

  String get selectedStatus => _selectedStatus;
  set selectedStatus( String valor ) {
    _selectedStatus = valor;

    isLoading = true;
    getServicesByCategory( _selectedCategory, valor );
    notifyListeners();
  }

  
  List<Service> get getServices => services;


  getServicesByCategory( String category, String status ) async {

    final url =  Uri.parse( '${ Environment.apiUrl }/service/all/$status/$category' );

    final resp = await http.get( url ,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final servicesResponse = servicesResponseFromJson( resp.body );

    services.clear();
    services.addAll( servicesResponse.services );

    
    isLoading = false;

    notifyListeners();
  }


  Future<List<Report>> getReports( ) async {


    final accessToken = await storage.read(key: 'accessToken');

    final resp = await http.get( Uri.parse( '${ Environment.apiUrl }/report/notassigned'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    final reportsResponse = reportsResponseFromJson( resp.body );

    if ( !reportsResponse.status ) {
      return [];
    }
    return reportsResponse.reports;
  }





  Future saveOrCreateReport( Report? report ) async {

    isSaving = true;
    notifyListeners();

    bool status = false;

    if ( report!.id == null ) {
      // Crear
      status = await create( report );
    } else {
      // Actualizar
      status = await updateReport(report);
    } 

    isSaving = false;
    notifyListeners();

    return status;


  }



  Future<bool> updateReport( Report report ) async {


    final accessToken = await storage.read(key: 'accessToken');

    final url = Uri.parse( '${ Environment.apiUrl }/report/${ report.id }' );
    final resp = await http.put( url ,
      body: reportToJson(report),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    final reportResponse = reportResponseFromJson(resp.body);

    await uploadImage();

    return reportResponse.status;
  }



  Future<bool> create( Report report ) async {


    final accessToken = await storage.read(key: 'accessToken');

    final url = Uri.parse( '${ Environment.apiUrl }/report/create' );
    final resp = await http.post( url ,
      body: reportToJson(report),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    final reportResponse = reportResponseFromJson(resp.body);

    await uploadImage();

    return reportResponse.status;
  }


  void updateSelectedReportImage( String path ) {
    selectedReport.image = path;
    newPictureFile = File.fromUri( Uri(path: path) );
    notifyListeners();
  }


  Future uploadImage() async {

    print( newPictureFile );

    if ( newPictureFile == null ) return;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('${ Environment.apiUrl }/upload/reports/${ selectedReport.id }');

    final imageUploadRequest = http.MultipartRequest('PUT', url);

    final file = await http.MultipartFile.fromPath('image', newPictureFile!.path );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    print( resp.body );

  }




   

}

