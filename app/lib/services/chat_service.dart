

import 'package:idaipqroo/global/environment.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {

  // Para quien van los mensajes
  // late User userTo;

  Future getMessagesChat( String userId ) async {

    final resp = await http.get( Uri.parse('${ Environment.apiUrl }/message/$userId') ,
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${ await AuthService.getToken() }'
      }
    );

    final messagesResp = messagesChatResponseFromJson(resp.body);

    return messagesResp.messages;

  }


}