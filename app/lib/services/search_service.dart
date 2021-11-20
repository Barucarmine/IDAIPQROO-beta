

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';


class SearchService extends ChangeNotifier {


  List<Service> historial = [];


  addHostorial( Service service ) {

    bool exist = false;
    historial.forEach((element) {
      if ( element.id == service.id ) {
        exist = true;
        return;
      }
    });

    if ( !exist ){
      historial.insert(0, service);
    }

    notifyListeners();
  }


  Future<List<Service>> getServiceByTermino( String termino ) async {


    final resp = await http.get( Uri.parse( '${ Environment.apiUrl }/search/$termino'),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    final searchResponse = searchResponseFromJson( resp.body );

    if ( !searchResponse.status ) {
      return [];
    }

    return searchResponse.services;
  }


  

}