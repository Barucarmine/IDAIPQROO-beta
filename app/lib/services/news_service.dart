
import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/global/environment.dart';
import 'package:http/http.dart' as http;


class NewsService with ChangeNotifier {

 
  Future<List<New>> getNews() async {

    final url =  Uri.parse( '${ Environment.apiUrl }/new/all' );

    final resp = await http.get( url ,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final newsResponse = newsResponseFromJson( resp.body );

    if ( !newsResponse.status ){
      return [];
    }

    print(newsResponse.news);
    return newsResponse.news;
    
  }

}