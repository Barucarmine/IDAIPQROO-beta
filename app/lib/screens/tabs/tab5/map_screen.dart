

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {

  Completer<GoogleMapController> _controller = Completer();

  /* List<Marker> mapMarkers = [
    Marker(
        markerId: MarkerId("sjdaksjdkl"),
        position: LatLng(37.43296265331129, -122.08832357078792),
      )
  ]; */


  @override
  Widget build(BuildContext context) {

    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
        body: Stack(
          children: [

            !mapProvider.isLoading 
              ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mapProvider.locationReport,
                zoom: 19
              ),
              // No poder mover el mapa
              // scrollGesturesEnabled: false,
              zoomControlsEnabled: false,
              // markers: mapMarkers.toSet(),
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
              },
              onCameraMove: (CameraPosition cp){
                mapProvider.locationCenter = cp.target;
              },
            )
            : Container(),


            _MarcadorManual()



          ],
        )
      );
  }

}



class _MarcadorManual extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final mapProvider = Provider.of<MapProvider>(context);
    final reportsForm = Provider.of<ReportFormProvider>(context);
    final report = reportsForm.report;

    return Stack(
      children: [

        // Boton Regresar
        Positioned(
          top: size.height * 0.05,
          left: size.width * 0.06,
          child: FadeInLeft(
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon( Icons.arrow_back, color: Colors.black ),
                onPressed: () => Navigator.pop(context)
              ),
            ),
          ) 
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


        //Boton confirmar destion

        Positioned(
          bottom: size.height * 0.07,
          left: size.width * 0.1,
          child: FadeInLeft(
            child: MaterialButton(
              minWidth: size.width - 70,
              child: Text('Confirmar ubicación',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              elevation: 0,
              splashColor: Colors.transparent,
              shape: StadiumBorder(),
              color: Colors.black,
              onPressed: () {

                final location =  mapProvider.locationCenter;

                report.location = Location(
                  lat: location.latitude,
                  lng: location.longitude,
                );

                Navigator.pop(context);
              }
            ),
          )
        )

      ],
    );
  }

}