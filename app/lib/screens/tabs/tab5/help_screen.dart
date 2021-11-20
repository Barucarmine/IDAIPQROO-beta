

import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {

  List<Map<String, dynamic>> options = [
    { 
      'icon': Icons.note_alt_outlined, 
      'text': 'Crear reportes',
      'route': 'myReports'
    },
    { 
      'icon': Icons.notes, 
      'text': 'Consulta sobre reportes',
      'route': 'help' 
    },
    { 
      'icon': Icons.cancel_outlined,
      'text': 'Dudas sobre como cancelar un reporte',
      'route': 'about'
    },
    { 
      'icon': Icons.face_outlined,
      'text': 'Dudas sobre como unirse a un reporte',
      'route': 'about'
    },
    { 
      'icon': Icons.phone, 
      'text': 'Como comunicarme con una Institución Pública',
      'route': 'about'
    },
    { 
      'icon': Icons.chat, 
      'text': 'Como enviar mensaje a idaipqroo',
      'route': 'about'
    },
    { 
      'icon': Icons.star_border_outlined,
      'text': 'Como calificar el servicio que me brindan',
      'route': 'about'
    },
    { 
      'icon': Icons.info_outline, 
      'text': 'Terminos y Condiciones',
      'route': 'about'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda'),
      ),
      body:ListView.separated(
        itemBuilder: ( context, i) => _itemListTile( context, options[i] ),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: options.length
      ),
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