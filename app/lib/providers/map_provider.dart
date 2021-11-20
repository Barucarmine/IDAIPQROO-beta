




import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {


  late LatLng latLngUser;
  bool isLoading = true;

  late LatLng _locationCenter;
  late LatLng _locationReport;

   MapProvider(){
    getPosicion();
  }

  LatLng get locationCenter => _locationCenter;
  set locationCenter( LatLng valor ) {
    _locationCenter = valor;
    notifyListeners();
  }
  
  LatLng get locationReport => _locationReport;
  set locationReport( LatLng valor ) {
    _locationReport = valor;
    notifyListeners();

  }


  Future getPosicion() async {
    isLoading = true;
    notifyListeners();
    
    final posicion = await Geolocator.getCurrentPosition();
    print( ' posicion $posicion'  );
    latLngUser = LatLng(posicion.latitude, posicion.longitude);
    _locationCenter = latLngUser;

    isLoading = false;
    notifyListeners();
  }


}