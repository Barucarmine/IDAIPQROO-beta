

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:idaipqroo/ui/input_decorations.dart';
import 'package:idaipqroo/widgets/my_button.dart';

class AboutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('idaipqroo app')
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.',
                  textAlign: TextAlign.justify,
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Text('Danos tu opinión', 
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20
                )
              ),

              SizedBox(
                height: 20,
              ),

              RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: '',
                        onChanged: ( value ) {},
                        validator: ( value ) {
                          if ( value == null || value.isEmpty ){
                            return 'Tu comentario es requerido';
                          }
                        },
                        decoration: InputDecorations.authInputDecoration(
                          labelText: 'Comentario',
                          hintText: 'Escribe un comentario', 
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      MyButton(
                        color: Color(0xFF7E57C2),
                        text: 'Calificar',
                        onPressed: () {
                        }
                      ),

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      )
    );
  }

}