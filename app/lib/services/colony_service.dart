



import 'package:flutter/material.dart';
import 'package:idaipqroo/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:idaipqroo/models/models.dart';


class ColonyService extends ChangeNotifier {

  List<String> colonies = [];
  bool _isLoading = false;

  Report report;

  bool get isLoading => _isLoading;
  
  ColonyService( this.report  ){
    
    if ( report.id != null ) {
      getColonyByMunicipality(report.municipality);
    } 

  }


  getColonyByMunicipality( String? municipality ) async{

    _isLoading = true;
    notifyListeners();

    final resp = await http.get( Uri.parse( '${ Environment.apiUrl }/municipality/colonies/$municipality'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final coloniesResponse = coloniesResponseFromJson( resp.body );

    colonies.clear();
    colonies.addAll( coloniesResponse.colonies );


    _isLoading = false;

    notifyListeners();

  }

}