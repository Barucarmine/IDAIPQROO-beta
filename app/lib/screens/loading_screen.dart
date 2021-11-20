

import 'package:flutter/material.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/screens/screens.dart';
import 'package:idaipqroo/services/auth_service.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context, snapshot ) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepPurple,
                      Color(0xFF7E57C2),
                      Color(0xFF9575CD),
                      Color(0xFFB39DDB)
                    ]
                  )
                ),
                child: Center(
                  child: Image(
                    width: 100,
                    image: AssetImage('assets/images/logo.png')
                  )
                ),
              ),
            ],
          );
        },
      )
    );
  }


  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketProvider>(context, listen: false);

    final isAuthenticated = await authService.isLoggedIn();

    if ( isAuthenticated ) {
      /* CONECTAR AL SOCKET SERVICE */
      socketService.connect();
      // Navigator.pushReplacementNamed(context, 'usuarios');
      /* Para evitar la animación del cambio de pantalla */
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_,__,___) => HomeScreen(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_,__,___) => LoginScreen(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    }

  }

}