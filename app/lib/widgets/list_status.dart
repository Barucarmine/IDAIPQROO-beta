

import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';


class ListStatus extends StatelessWidget {

  final List<Status> status;

  ListStatus({ required this.status});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.035,
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 5
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: status.length,
        itemBuilder: (BuildContext context, int i ) {
          return _StatusItem(
            status: status[i],
          );
        },
      ),
    );
  }


}



class _StatusItem extends StatelessWidget {

  final Status status;
  
  _StatusItem({required this.status});

  @override
  Widget build(BuildContext context) {

    final reportsService = Provider.of<ReportsService>(context); 

    return GestureDetector(
      onTap:  reportsService.selectedStatus == status.value 
          ? null 
          : () => reportsService.selectedStatus = status.value,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        margin: const EdgeInsets.only(
          left: 5,
        ),
        decoration: BoxDecoration(
          color:  Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(20),
          border: ( reportsService.selectedStatus == status.value  ) 
            ? Border.all(
              color: Color(0xFF7E57C2),
              width: 1.3
            )
            : null
        ),
        child: Center(
          child: Text( status.title,
            style: TextStyle(
              fontSize: 14,
              //color: Colors.white
              color: ( reportsService.selectedStatus == status.value  ) ? Color(0xFF7E57C2): Color(0xFF9575CD), 
          )
        ),
      ),
      )
    );
  }


}