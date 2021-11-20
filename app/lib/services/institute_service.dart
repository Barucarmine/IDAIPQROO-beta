import 'package:flutter/material.dart';
import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:http/http.dart' as http;


class InstituteService with ChangeNotifier {

  List<String> municipalities = [
        "Bacalar",
        "Benito Juárez",
        "Cozumel",
        "Felipe Carrillo Puerto",
        "Isla Mujeres",
        "José María Morelos",
        "Lázaro Cárdenas",
        "Othón P. Blanco",
        "Puerto Morelos",
        "Solidaridad",
        "Tulum",
  ];
  String _selectedMunicipality = 'Othón P. Blanco';

  bool _isLoading = true;

  
  List<Institute> institutes = [];

      
  InstituteService() {
    getInstitutesByMunicipality( _selectedMunicipality );
  }

  bool get isLoading => _isLoading;


  String get selectedMunicipality => _selectedMunicipality;
  set selectedMunicipality( String valor ) {
    _selectedMunicipality = valor;

    _isLoading = true;
    getInstitutesByMunicipality( valor );
    notifyListeners();
  }
  
  List<Institute>? get getInstitutes => institutes;





  getInstitutesByMunicipality( String municipality ) async {

    _isLoading = true;

    final resp = await http.get( Uri.parse( '${ Environment.apiUrl }/institute/all/$municipality'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print( resp.body );
    final institutesResponse = institutesResponseFromJson( resp.body );

    institutes.clear();
    institutes.addAll( institutesResponse.institutes );

    _isLoading = false;

    notifyListeners();
  }


}