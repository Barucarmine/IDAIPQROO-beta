import 'dart:io';

import 'package:flutter/material.dart';

class ReportImage extends StatelessWidget {

  final String? url;

  ReportImage({
    this.url
  });


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only( left: 10, right: 10, top: 10 ),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: size.height * 0.34,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.only( topLeft: Radius.circular( 40 ), topRight: Radius.circular(40) ),
            child: getImage(url)
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.only( topLeft: Radius.circular( 40 ), topRight: Radius.circular( 40 ) ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.0),
        blurRadius: 10,
        offset: Offset(0,5)
      )
    ]
  );


  Widget getImage( String? picture ) {

    if ( picture == null ) 
      return Image(
          image: AssetImage('assets/images/no-image.jpg'),
          fit: BoxFit.cover,
        );

    if ( picture.startsWith('http') ) 
        return FadeInImage(
          image: NetworkImage( this.url! ),
          placeholder: AssetImage('assets/images/loading.gif'),
          fit: BoxFit.cover,
        );


    return Image.file(
      File( picture ),
      fit: BoxFit.cover,
    );
  }

}