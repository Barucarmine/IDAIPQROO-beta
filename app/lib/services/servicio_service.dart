

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:http/http.dart' as http;


class ServicioService with ChangeNotifier {


  late Service serviceSelected;

  bool isLoading = false;

  final storage = new FlutterSecureStorage();



  Future<bool> joingMe() async {

    isLoading = true;
    notifyListeners();

    final accessToken = await storage.read(key: 'accessToken');

    final url = Uri.parse( '${ Environment.apiUrl }/report/joinuser/${ serviceSelected.id }' );
    final resp = await http.get( url ,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    final serviceJoinResponse = serviceJoinResponseFromJson(resp.body);

    if ( serviceJoinResponse.service != null ) {
      serviceSelected = serviceJoinResponse.service!;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();

    return serviceJoinResponse.status;
  }


}