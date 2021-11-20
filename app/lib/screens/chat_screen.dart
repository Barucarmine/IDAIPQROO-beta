

import 'dart:io';

import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

/* Para hacer la animación */
class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  late ChatService chatService;
  late SocketProvider socketProvider;
  late AuthService authService;

  bool _isWriting = false;

  List<ChatMessage> _messages = [];


  @override
  void initState() {
    super.initState();

    chatService   = Provider.of<ChatService>(context, listen: false);
    socketProvider = Provider.of<SocketProvider>(context, listen: false);
    authService   = Provider.of<AuthService>(context, listen: false);

    socketProvider.socket.on('personal-message', _listenMessage );

    // _cargarHistorial( chatService.userTo.id );
    _cargarHistorial( '6170901305a750d238f5eefc' );

  }


  void _cargarHistorial( String userId ) async{

    List<Message> messagesChat = await chatService.getMessagesChat( userId );

    final history = messagesChat.map( (m) => new ChatMessage(
      texto: m.message,
      uid: m.from,
      animationController: new AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 0
        )
      )..forward(),
    ));

    setState((){
      this._messages.insertAll(0, history);
    });

  }

  void _listenMessage( dynamic payload ) {
    // print( 'Tengo mensaje $data' );
    ChatMessage message = new ChatMessage(
      uid: payload['from'],
      texto: payload['message'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300
        )
      )
    );


    setState((){
      this._messages.insert(0, message);
    });

    // Empezar la animación
    message.animationController.forward();

  }


  @override
  Widget build(BuildContext context) {

    // final userTo = chatService.userTo;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('idaipqroo'),
      ),
      body: Container(
        child: Column(
          children: [

            Flexible(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (_, index) => _messages[index],
                  reverse: true,
                ),
              )
            ),


            Divider(
              height: 1,
            ),

            Container(
              color: Colors.grey[100],
              child: _buildInputChat()
            )

          ],
        )
      )
    );
  }

  Widget _buildInputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          
        ),
        child: Row(
          children: [

            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( value ) {
                  // Cuando hay un valor para poder enviar mensaje
                  setState(() {
                    value.trim().length > 0 
                      ? _isWriting = true
                      : _isWriting = false;
                  
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Escribir mensaje'
                ),
                focusNode: _focusNode
              ),
            ),

            /* Botón enviar  */
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 4.0
              ),
              child: Platform.isIOS 
                ? CupertinoButton(
                  child: Text('Enviar'), 
                  onPressed: _isWriting 
                        ? () => _handleSubmit( _textController.text.trim() )
                        : null
                  )
                : Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.0
                  ),
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.deepPurple[400]
                    ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon( Icons.send ),
                      onPressed: _isWriting 
                        ? () => _handleSubmit( _textController.text.trim() )
                        : null
                    ),
                  )
                )
              ,
            )

          ],
        ),
      ),
    );
  }


  _handleSubmit( String texto ){
    
    print( texto );
    /* validacion para que no pueda enviar si no hay algo escrito */
    if ( texto.length == 0 ) return;
    /* Limpiar la caja de texto */
    _textController.clear();
    /* Mantener el foco en el input */
    _focusNode.requestFocus();

    final newMessage = ChatMessage( 
      uid: this.authService.user.id, 
      texto: texto,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 400
        )
      ),
    );
    /* Añadir nuevo mensaje al listado */
    _messages.insert(0, newMessage);
    /* disparar la animación */
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
    

    // Mandar mensaje
    socketProvider.emit('personal-message', {
      'from': authService.user.id,
      'to': '619067b475caa4461d92cd7a',
      'message': texto
    });
  }


  @override
  void dispose() {

    // limpieza de los animation controllers
    for( ChatMessage message in _messages ){
      message.animationController.dispose();
    }

    // Dejar de escuchar los personal-messages
    socketProvider.socket.off('personal-message');
    super.dispose();
  }

}


