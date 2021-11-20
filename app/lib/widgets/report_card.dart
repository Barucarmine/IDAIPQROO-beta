



import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';

class ReportCard extends StatelessWidget {

  final Service service;

  ReportCard({ required this.service });


  @override
  Widget build(BuildContext context) {

    final servicioService = Provider.of<ServicioService>(context);
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        servicioService.serviceSelected = service;
        // Navigator.pushNamed(context, 'service', arguments: service );
        Navigator.pushNamed(context, 'service' );
        
      },
      child: Container(
        height: size.height * 0.43,
        margin: const EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: 8
        ),
        decoration: _cardDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
              _Image(
                service: service,
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: Text( service.report.title ,
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
                child: Text( service.report.description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        child: FadeInImage(
                            image: NetworkImage( service.institute.getImage() ),
                            placeholder: AssetImage('assets/images/loading.gif'),
                            fit: BoxFit.cover,
                          ),
                      ),
                    ),

                    SizedBox(
                      width: size.width * 0.01,
                    ),

                    Expanded(
                      child: Text( service.institute.name ,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )

                    
                  ],
                ),
              )

              ],
            )
          ),
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

  final Service service;

  const _Image({required this.service});

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
                image: NetworkImage( service.report.getImage() ),
                placeholder: AssetImage('assets/images/loading.gif'),
                height: size.height * 0.23,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Positioned(
          top: 0,
          right: 0,
          child: _StatusTag(
            status: service.status,
          )
        ),


        Positioned(
          bottom: 0,
          right: 0,
          child: _UsersTag(
            service: service,
          )
        ),

        ],
      );
  }
}

class _StatusTag extends StatelessWidget {

  final String status;

  const _StatusTag({ required this.status }); 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            status == 'PROCESS' 
                ? 'En proceso'
                : status == 'FINALIZED' ? 'Finalizado' : 'Cancelado',
            style: TextStyle( color: Colors.white, fontSize: 18 ),
          ),
        ),
      ),
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: status == 'PROCESS' 
                ? Colors.amber[400]
                : status == 'FINALIZED' ? Colors.green[400] : Colors.red[400],
        borderRadius: BorderRadius.only( topRight: Radius.circular(10), bottomLeft: Radius.circular(10) )
      ),
    );
  }
}




class _UsersTag extends StatelessWidget {

  final Service service;

  const _UsersTag({ required this.service });



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon( Icons.face_outlined, color: Colors.white),
              Text(
                '${service.contributions}',
                style: TextStyle( color: Colors.white, fontSize: 14 ),
              ),
            ],
          ),
        ),
      ),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }
}


