import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/ui/input_decorations.dart';
import 'package:idaipqroo/widgets/my_button.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatelessWidget {
  
  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {

  // final Service service = ModalRoute.of(context)!.settings.arguments as Service;
  final servicioService = Provider.of<ServicioService>(context);
  final service = servicioService.serviceSelected;
  final size = MediaQuery.of(context).size;


    return Scaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        slivers: [

          _CustomAppBar( service.report ),

          SliverList(
            delegate: SliverChildListDelegate([

              SizedBox(
                height: size.width * 0.05,
              ),

            !service.report.anonymous ?
              Container(
                padding: EdgeInsets.all( size.width * 0.03),
                child: Row(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: size.width * 0.15,
                        width: size.width * 0.15,
                        child: FadeInImage(
                            image: NetworkImage( service.report.user!.getImage() ),
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
                          Text( 'Usuario que reporto:', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ) ),
                          SizedBox(
                            height: size.height * 0.005
                          ),
                          Text( service.report.user!.name, style: TextStyle( color: Colors.black54 ) ),
                        ],
                      ),
                    )

                  ],
                ),
              )
              : (Container()),

              _CustomTitle(service),

              _Overview( service.report ),
              
              _CustomDatos( service ),

              SizedBox(
                height: size.width * 0.05,
              ),

              (service.report.location != null)  ?
                (

                  
                SizedBox(
                  height: size.height * 0.4,
                  child: Stack(

                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(service.report.location!.lat, service.report.location!.lng ),
                          zoom: 16
                        ),
                        zoomControlsEnabled: false,
                        scrollGesturesEnabled: false,
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                        },
                      ),
                    

                    Center(
                      child: Transform.translate(
                        offset: Offset(0, -18),
                        child: BounceInDown(
                          from: 100,
                          child: Icon( Icons.location_on, size: 40, color: Colors.red)
                        ),
                      ),
                    ),

                    ],
                  ),
                ) )
                : ( Container() ),
                
                SizedBox(
                  height: size.width * 0.05,
                ),


                Container(
                padding: EdgeInsets.all( size.width * 0.03),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: size.width * 0.15,
                        width: size.width * 0.15,
                        child: FadeInImage(
                            image: NetworkImage( service.institute.getImage() ),
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
                          Text( 'Institución a cargo:', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ) ),
                          SizedBox(
                            height: size.height * 0.005
                          ),
                          Text( service.institute.name, style: TextStyle( color: Colors.black54 ) ),
                        ],
                      ),
                    )

                  ],
                ),
              ),



            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 8
              ),
              child: Text(
                'Ultima actualización',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18
                )
              ),
            ),

            service.observations != null 
              ? _Observations( service ) : Container(),


            service.status != 'FINALIZED' ? SizedBox(
                height: size.width * 0.17,
              ) : Container(),

            service.status == 'FINALIZED' ? _Calification() : Container(),

              service.status == 'FINALIZED' ? SizedBox(
                height: size.width * 0.15,
              ) : Container(),
            ]),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {

          final status = await servicioService.joingMe();

          if (!status) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Ya estás unido.'),
              duration: Duration(milliseconds: 3500),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Gracias por unirte.'),
              duration: Duration(milliseconds: 3500),
            ));
          }
        },
        label: const Text('Contribuir'),
        icon: const Icon(Icons.face_outlined ),
        backgroundColor: Colors.purple,
      ),
    );
  }

}

class _CustomTitle extends StatelessWidget {

  final Service service;

  _CustomTitle( this.service );


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    return Container(
      padding: EdgeInsets.all( size.width * 0.03),
      child: Row(
        children: [
          Container(
            width: size.width * 0.7,
            child: Text( service.report.title ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
                textAlign: TextAlign.center),
          ),

          Expanded(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Icon( Icons.face_outlined, size: 26 ),
                      Text( service.contributions.toString(), style: TextStyle(
                        fontSize: 18,
                      ))

                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: service.status == 'PROCESS' 
                              ? Colors.amber[400]
                              : service.status == 'FINALIZED' ? Colors.green[400] : Colors.red[400],
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text( service.status == 'PROCESS' 
                                ? 'En proceso'
                                : service.status == 'FINALIZED' ? 'Finalizado' : 'Cancelado',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class _CustomAppBar extends StatelessWidget {

  final Report report;

  const _CustomAppBar( this.report );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
        backgroundColor: Colors.purple,
        expandedHeight: size.height * 0.27,
        floating: false,
        pinned: true,
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          color: Colors.white,
          icon: const Icon( Icons.arrow_back ),
          onPressed: () => Navigator.pop( context )
        ),
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          centerTitle: true,
          title: Container(
              width: double.infinity,
              color: Colors.black12,
              padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
              alignment: Alignment.bottomCenter,
              /* child: Text( report.title, 
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ) */),
          background: FadeInImage(
              placeholder: AssetImage('assets/images/loading.gif'),
              image: NetworkImage( report.getImage() ),
              fit: BoxFit.cover),
        ));
  }
}


class _Overview extends StatelessWidget {

  final Report report;

  const _Overview( this.report );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all( size.width * 0.03),
      child: Text( report.description ,
      textAlign: TextAlign.justify),
    );
  }
}




class _CustomDatos extends StatelessWidget {

  final Service service;

  const _CustomDatos( this.service );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        _CustomInfo('Categoría:', service.report.category! ),
        _CustomInfo('Municipio:', service.report.municipality! ),
        _CustomInfo('Colonia:', service.report.colony! ),
      ],
    );
  }
}

class _CustomInfo extends StatelessWidget {

  final String title;
  final String info;

  _CustomInfo( this.title, this.info );

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all( size.width * 0.03),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.25,
            child: Text( title, style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54
            ) )
          ),
          Expanded(
            child: Text( info, 
              style: TextStyle(
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3
            )
          ),
        ],
      ),
    );
  }
}


class _Observations extends StatelessWidget {

  final Service service;

  const _Observations( this.service );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all( size.width * 0.03),
      child: Text( service.observations!,
      textAlign: TextAlign.justify),
    );
  }
}




class _Calification extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text('Califica el servico', 
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
                        color: Colors.purple,
                        text: 'Calificar',
                        onPressed: () {
                        }
                      ),

                    ],
                  ),
                ),
              )

      ],
    );
  }
}