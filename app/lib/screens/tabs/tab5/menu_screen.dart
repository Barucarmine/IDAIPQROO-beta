

import 'package:flutter/material.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {

   List<Map<String, dynamic>> options = [
    { 
      'icon': Icons.note_alt_outlined, 
      'text': 'Mis reportes',
      'route': 'myReports'
    },
    { 
      'icon': Icons.help_outline, 
      'text': 'Ayuda',
      'route': 'help' 
    },
    { 
      'icon': Icons.info_outline, 
      'text': 'Acerca de idaipqroo app',
      'route': 'about'
    },
  ];

  @override
  Widget build(BuildContext context) {

    final socketProvider = Provider.of<SocketProvider>(context);
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          // padding: const EdgeInsets.all(15.0),
          padding: EdgeInsets.all( size.width * 0.04 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: size.width * 0.25,
                  width: size.width * 0.25,
                  child: FadeInImage(
                      image: NetworkImage( user.getImage() ),
                      placeholder: AssetImage('assets/images/loading.gif'),
                      fit: BoxFit.cover,
                    ),
                ),
              ),

              SizedBox(
                width: size.width * 0.04,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( user.name , 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text( user.email , 
                      style: TextStyle(
                        color: Colors.black45,
                      ),

                    )
                  ],
                ),
              ),

              SizedBox(
                width: size.width * 0.04,
              ),

              const Icon ( Icons.arrow_forward_ios_rounded, size: 18, color: Colors.black45 )

            ],
          ),
        ),

        const Divider(),

        Expanded(
          child: ListView.separated(
            itemBuilder: ( context, i) => _itemListTile( context, options[i] ),
            separatorBuilder: (_, i) => const Divider(),
            itemCount: options.length
          ),
        ),

        ListTile(
          title: Text( 'Cerrar sesión' ),
          leading: Icon( Icons.logout_outlined ),
          onTap: () {
            /* Desconectarme de mi servidor sockets */
            socketProvider.disconnect();
            /* Hacer el logout desde mi metodo estático */
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        )

      ],
    );
  }


  ListTile _itemListTile( BuildContext context, Map<String, dynamic> opt ) {
    return ListTile(
      title: Text( opt['text'] ),
      leading: Icon( opt['icon'] ),
      trailing: const Icon ( Icons.arrow_forward_ios_rounded, size: 18 ),
      onTap: () {
        Navigator.pushNamed(context, opt['route'] );
      },
    );
  }

}