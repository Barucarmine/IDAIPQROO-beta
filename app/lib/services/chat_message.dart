
import 'package:idaipqroo/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  ChatMessage({ required this.texto, required this.uid, required this.animationController});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false );
    
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut
      ),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          child: this.uid == authService.user.id
            ? _MyMessage(
              texto: this.texto
            )
            : _NotMyMessage(
              texto: this.texto
            )
        ),
      ),
    );
  }


}



class _MyMessage extends StatelessWidget {

  final String texto;

  const _MyMessage({ required this.texto });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsetsDirectional.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          right: 5,
          left: 100,
        ),
        child: Text( this.texto,
          style: TextStyle(
            color: Colors.white
          )
        ),
        decoration: BoxDecoration(
          color: Colors.deepPurple[300],
          borderRadius: BorderRadius.circular(20)
        ),
      )
    );
  }
}



class _NotMyMessage extends StatelessWidget {

  final String texto;

  const _NotMyMessage({ required this.texto });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsetsDirectional.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 5,
          right: 100,
        ),
        child: Text( this.texto,
          style: TextStyle(
            color: Colors.white
          )
        ),
        decoration: BoxDecoration(
          color: Color(0xff21B7F6),
          borderRadius: BorderRadius.circular(20)
        ),
      )
    );
  }
}