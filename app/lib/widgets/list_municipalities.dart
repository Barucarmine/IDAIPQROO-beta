

import 'package:flutter/material.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';


class ListMunicipalities extends StatelessWidget {

  final List<String>? municipality;

  ListMunicipalities({this.municipality});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.045,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: municipality?.length,
        itemBuilder: (BuildContext context, int i ) {
          return _MunicipalityItem(
            municipaly: municipality![i],
          );
        },
      ),
    );
  }

}




class _MunicipalityItem extends StatelessWidget {

  final String municipaly;

  _MunicipalityItem({required this.municipaly});

  @override
  Widget build(BuildContext context) {

    final instituteService = Provider.of<InstituteService>(context);


    return GestureDetector(
      onTap: 
        instituteService.selectedMunicipality == municipaly 
          ? null 
          : () => instituteService.selectedMunicipality = municipaly,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 5
        ),
        decoration: BoxDecoration(
          color: ( instituteService.selectedMunicipality == municipaly ) ? Color(0xFF7E57C2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text( '$municipaly',
            style: TextStyle(
              fontSize: 16,
              //color: Colors.white
              color: ( instituteService.selectedMunicipality == municipaly ) ? Colors.white : Colors.black54
            ), 
          )
        ),
      ),
    );
  }

}