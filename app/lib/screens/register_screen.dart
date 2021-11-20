

import 'package:flutter/material.dart';
import 'package:idaipqroo/helpers/alerts.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.96,
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
        
                _Header(),
        
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _Form()
                ),
        
                Labels(
                  title: "¿Ya tienes una cuenta?",
                  textButton: '¡Iniciar sesion ahora!',
                  onTap: () => Navigator.pushReplacementNamed(context, 'login')
                ),

                const Text('Términos y condiciones.',
                  style: TextStyle(
                    fontWeight: FontWeight.w200
                  )
                )
        
              ],
            ),
          ),
        )
      )
    );
  }

}



class _Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {



    return Column(
      children: [

        Center(
          child: Image(
            width: 100,
            image: AssetImage('assets/images/logo.png')
          ),
        ),

        // SizedBox(
        //   height: 15,
        // ),

        // Text('Registrate a', style: TextStyle( fontSize: 25 ) ),
      ],
    );
  }

}



class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketProvider>(context );
    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginFormProvider.formKey,
      child: Column(
        children: [

          CustomInput(
            prefixIcon: Icons.face_outlined,
            labelText: 'Nombre',
            hintText: 'Escribe tu nombre',
            validator: ( value ) {
              return ( value != null && value.isNotEmpty ) 
                ? null
                : 'Este campo es requerido';
            },
            onChanged: ( value ) => loginFormProvider.name = value,
          ),

          CustomInput(
            prefixIcon: Icons.alternate_email_outlined,
            labelText: 'Correo electrónico',
            hintText: 'ejemplo@ejemplo.com',
            validator: ( value ) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                ? null
                : 'Correo electrónico inválido';
            },
            onChanged: ( value ) => loginFormProvider.email = value,
          ),

          CustomInput(
            prefixIcon: Icons.password_outlined,
            labelText: 'Contraseña',
            hintText: 'Escribe tu contraseña',
            obscureText: true,
            validator: ( value ) {
              return ( value != null && value.length >= 6 ) 
                ? null
                : 'Mínimo 6 caracteres';
            },
            onChanged: ( value ) => loginFormProvider.password = value,
          ),
          

          const SizedBox(
            height: 20,
          ),

          MyButton(
            color: Colors.deepPurple,
            text: 'Registrarme',
            onPressed: authService.isAuthenticating ? null : () async{

              if ( !loginFormProvider.isValidForm() ) return;

              final registerStatus = await authService.register( loginFormProvider.name.trim(), loginFormProvider.email.trim(), loginFormProvider.password.trim());
              /* registerStatus retorna un bool true si esta bien o String con el mensaje de error  */
              if ( registerStatus == true ) {
                // Conectar al socket server
                socketService.connect();
                print( registerStatus );

                Navigator.pushReplacementNamed(context, 'home');
              } else {
                print( registerStatus );

                mostrarAlerta(context, 'Error', registerStatus );
              }

            }
          )

        ],
      ),
    );
  }
}

