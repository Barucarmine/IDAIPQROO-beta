
import 'package:flutter/material.dart';
import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:http/http.dart' as http;


class IdaipService with ChangeNotifier  {


  bool _isLoading = true;
  late User user;

  IdaipService(){
    getProfile();
  }

  bool get isLoading => _isLoading;

  getProfile() async {

    _isLoading = true;

    final resp = await http.get( Uri.parse( '${ Environment.apiUrl }/user/admin'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final adminResponse = adminResponseFromJson( resp.body );

    user = adminResponse.user;

    _isLoading = false;

    notifyListeners();
  }

  Future<List<Event>> getEvents() async {


    final resp = await http.get( Uri.parse( '${ Environment.apiUrl }/event/all'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final eventsResponse = eventsResponseFromJson( resp.body );

    if( !eventsResponse.status ){
      return [];
    }

    print( eventsResponse.events );
    return eventsResponse.events;

  }

}