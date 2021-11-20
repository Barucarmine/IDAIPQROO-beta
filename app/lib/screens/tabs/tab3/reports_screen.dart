

import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final reportsService = Provider.of<ReportsService>(context);
    final reportFormProvider = Provider.of<ReportFormProvider>(context);

    return Stack(
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ListCategories(
                categories: reportsService.categories,
              ),

              ListStatus(
                status: reportsService.status,
              ),


              SizedBox(
                height: size.height * 0.007,
              ),


                if ( !reportsService.isLoading )
                  Expanded(child: _ListReports( 
                    services: reportsService.getServices,
                    height: size.height * 0.42,
                  )
                ),
                

                if ( reportsService.isLoading )
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                  
                  

            ],
        ),

        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton.extended(
            onPressed: () {


              reportsService.selectedReport = Report(
                anonymous: true,
                description: '',
                title: '',
              );
              
              
              reportFormProvider.report = reportsService.selectedReport;
              Navigator.pushNamed(context, 'report' );
            },
            label: const Text('Reportar'),
            icon: const Icon(Icons.add ),
            backgroundColor: Color(0xFF7E57C2),
          ),
        )


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




