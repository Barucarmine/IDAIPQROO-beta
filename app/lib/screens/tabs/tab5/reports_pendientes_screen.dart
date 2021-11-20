



import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ReportsPendientesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
    final reportsService = Provider.of<ReportsService>(context);

    return Container(
      child: FutureBuilder(
        future: reportsService.getReports(),
        builder: ( BuildContext context , AsyncSnapshot<List<Report>> snapshot ) {

          if ( snapshot.hasData ) {
            return _ListReports(
              reports: snapshot.data,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            );
          }


          
        },
      ),
    );
  }

}

class _ListReports extends StatelessWidget {

  List<Report>? reports;

  _ListReports({this.reports});

  @override
  Widget build(BuildContext context) => reports!.isNotEmpty

    

    ? ListView.builder(
        itemCount: reports!.length ,
        itemBuilder: (BuildContext context, int i ) {

          final reportsService = Provider.of<ReportsService>(context, listen:false);
          final reportFormProvider = Provider.of<ReportFormProvider>(context, listen:false);

          return GestureDetector(
            onTap: () {
              reportsService.selectedReport = reports![i].copy();
              reportFormProvider.report = reportsService.selectedReport;
              Navigator.pushNamed(context, 'report');
            },
            child: ReportNotAssignedCard(
              report: reports![i] ,
            ),
          );
        },
      )

    : Center(
        child: Text('vacío', 
          style: TextStyle( 
              color: Colors.grey[400] 
          ) 
        )
      );
  
}