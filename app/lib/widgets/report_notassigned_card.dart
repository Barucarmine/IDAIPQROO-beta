




import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';

class ReportNotAssignedCard extends StatelessWidget {

  final Report report;

  ReportNotAssignedCard({ required this.report });


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.43,
      margin: const EdgeInsets.only(
        right: 10,
        left: 10,
        bottom: 8,
        top: 8,
      ),
      decoration: _cardDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
            _Image(
              url: report.getImage(),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10
              ),
              child: Text( report.title ,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10
              ),
              child: Text( report.description,
                style: TextStyle(
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                maxLines: 3,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 15
              ),
              child: Text( 'En espera por asignar...' ,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red
                )
              ),
            )

            ],
          )
        );

  }

  BoxDecoration _cardDecoration()  => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 3,
        offset: Offset(0, 5),
      )
    ]
  );
  

}

class _Image extends StatelessWidget {

  final String url;

  const _Image({required this.url});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only( topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
          ),
          child: Opacity(
            opacity: 0.9,
            child: ClipRRect(
              borderRadius:  BorderRadius.only( topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
              child: FadeInImage(
                image: NetworkImage( url ),
                placeholder: AssetImage('assets/images/loading.gif'),
                height: size.height * 0.23,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

 

        ],
      );
  }
}