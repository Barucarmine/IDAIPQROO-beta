
import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyServicesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final userReportsService = Provider.of<UserReportsService>(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _Categories(
                  categories: userReportsService.categories,
          ),

          _ListStatus(
            status: userReportsService.status,
          ),


          SizedBox(
            height: size.height * 0.007,
          ),


            if ( !userReportsService.isLoading )
              Expanded(child: _ListReports( 
                services: userReportsService.getServices,
                height: size.height * 0.42,
              )
            ),
            

            if ( userReportsService.isLoading )
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ),
              
              

        ],
    );

  }

}

class _ListReports extends StatelessWidget {

  final List<Service> services;
  final double height;

  const _ListReports({ required this.services, required this.height});

  @override
  Widget build(BuildContext context) =>


    services.isNotEmpty ? 
      SizedBox(
        height: height,
        width: double.infinity,
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, int i ) {
            return ReportCard(
              service: services[i],
            );
          },
        ),
      )
    : Center(
        child: Text('vacío', 
          style: TextStyle( 
              color: Colors.grey[400] 
          ) 
        )
      );
  
}



class _Categories extends StatelessWidget {

  final List<String>? categories;

  _Categories({this.categories});

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
        itemCount: categories?.length,
        itemBuilder: (BuildContext context, int i ) {
          return _CategoryItem(
            category: categories![i],
          );
        },
      ),
    );
  }

}




class _CategoryItem extends StatelessWidget {

  final String category;

  _CategoryItem({ required this.category});

  @override
  Widget build(BuildContext context) {

    final userReportsService = Provider.of<UserReportsService>(context);


    return GestureDetector(
      onTap:  userReportsService.selectedCategory == category 
          ? null 
          : () => userReportsService.selectedCategory = category,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 5
        ),
        decoration: BoxDecoration(
          color: (userReportsService.selectedCategory == category ) ? Color(0xFF7E57C2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text( '$category',
            style: TextStyle(
              fontSize: 16,
              //color: Colors.white
              color: (userReportsService.selectedCategory == category ) ? Colors.white : Colors.black54
            ), 
          )
        ),
      ),
    );
  }

}




class _ListStatus extends StatelessWidget {

  final List<Status> status;

  _ListStatus({ required this.status});

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