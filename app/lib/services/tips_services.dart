
import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/global/environment.dart';
import 'package:http/http.dart' as http;


class TipsService with ChangeNotifier {


  Future<List<Tip>> getTips() async {

    final url =  Uri.parse( '${ Environment.apiUrl }/tip/all' );

    final resp = await http.get( url ,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final tipsResponse = tipsResponseFromJson( resp.body );

    if ( !tipsResponse.status ){
      return [];
    }

    print(tipsResponse.tips);
    return tipsResponse.tips;
    
  }

}