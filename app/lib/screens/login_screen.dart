
import 'package:flutter/material.dart';
import 'package:idaipqroo/helpers/alerts.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {


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
                  title: "¿No tienes una cuenta?",
                  textButton: '¡Registrarme!',
                  onTap: () => Navigator.pushReplacementNamed(context, 'register')
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
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
        

        /* const SizedBox(
          height: 15,
        ), */

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
    final socketProvider = Provider.of<SocketProvider>(context);
    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginFormProvider.formKey,
      child: Column(
        children: [

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
            labelText: 'Contaseña',
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
            text: 'Iniciar sesión',
            onPressed: authService.isAuthenticating ? null : () async {

                if ( !loginFormProvider.isValidForm() ) return;

                /* Quitar el foco del teclado o lo que sea */
                FocusScope.of(context).unfocus();

                final loginStatus = await authService.login( loginFormProvider.email.trim(), loginFormProvider.password.trim() );

                if ( loginStatus ) {
                  /* CONECTARME AL SERVIDOR SOCKETS */
                  socketProvider.connect();

                  /* Navegar a otra pantalla */
                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  /* Mostrar alerta */
                  mostrarAlerta(context, 'Error', 'Credenciales incorrectas');
                }

              },
          )

        ],
      ),
    );
  }
}

