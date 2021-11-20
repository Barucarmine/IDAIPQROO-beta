

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/ui/input_decorations.dart';
import 'package:idaipqroo/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class ReportScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final reportsService = Provider.of<ReportsService>(context);

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider( create: (_) => ReportFormProvider(report: reportsService.selectedReport) ),
        ChangeNotifierProvider( create: (_) => ColonyService(reportsService.selectedReport) )
      ],
      child: _ReportScreenBody(),
    );
  
    }
  
}

class _ReportScreenBody extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final reportsService = Provider.of<ReportsService>(context);
    final reportFormProvider = Provider.of<ReportFormProvider>(context);
    final size = MediaQuery.of(context).size;

    // reportFormProvider.report = reportsService.selectedReport;

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [

            Stack(
              children: [
                ReportImage(
                  url: reportsService.selectedReport.getImage()
                ),

                Positioned(
                  top: size.width * 0.08,
                  left:  size.width * 0.02,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    icon: Icon( Icons.arrow_back_rounded, size: 35, color: Colors.white ),
                  )
                ),

                Positioned(
                  top: size.width * 0.1,
                  right: size.width * 0.05,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () => _pickerPhoto( context, ImageSource.camera ), 
                          child: Icon( Icons.camera_alt_outlined, size: 30, color: Colors.white ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap:  () => _pickerPhoto( context, ImageSource.gallery ),
                          child: Icon( Icons.image, size: 30, color: Colors.white ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),

            _ReportForm()

          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7E57C2),
        child: Icon( Icons.save_outlined ),
        onPressed: () async {
          if ( !reportFormProvider.isValidForm() ) return;

          print(reportFormProvider.report.toJson()  );
          

          final status = await reportsService.saveOrCreateReport(reportFormProvider.report);

          if (status) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Reporte guardado con éxito.'),
              duration: Duration(milliseconds: 3500),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Oops! Ocurrio un error.'),
              duration: Duration(milliseconds: 3500),
            ));
          }

        },
      ),
    );
  }

  _pickerPhoto( BuildContext context, ImageSource source ) async {

    final reportsService = Provider.of<ReportsService>(context, listen: false);

    final picket = ImagePicker();

    final XFile? photo = await picket.pickImage(
      source: source,
      imageQuality: 100
    );

    if ( photo == null ) {
      print('No selecionó nada');
      return;
    }

    print( 'Tenemos imagen ${ photo.path }' );
    reportsService.updateSelectedReportImage(  photo.path );

  }
  
}




class _ReportForm extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final mapProvider = Provider.of<MapProvider>(context);
    final instituteService = Provider.of<InstituteService>(context);
    final colonyService = Provider.of<ColonyService>(context);
    final reportsService = Provider.of<ReportsService>(context);
    final reportsForm = Provider.of<ReportFormProvider>(context);
    final report = reportsForm.report;
    final size = MediaQuery.of(context).size;


    return Padding(
      padding: EdgeInsets.only(
        right: 10, 
        left: 10, 
        bottom: size.height * 0.07, 
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: reportsForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              SizedBox( height: size.height * 0.02),

              TextFormField(
                initialValue: report.title,
                onChanged: ( value ) => report.title = value,
                validator: ( value ) {
                  if ( value == null || value.isEmpty ){
                    return 'El titulo es requerido';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  labelText: '¿Cuál es el problema?', 
                  hintText: 'Escribe un titulo'
                ),
              ),

              SizedBox( height: size.height * 0.01),

              TextFormField(
                initialValue: report.description,
                onChanged: ( value ) => report.description = value,
                validator: ( value ) {
                  if ( value == null || value.isEmpty ){
                    return 'La descripción es requerido';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Describe el problema', 
                ),
              ),

              SizedBox( height: size.height * 0.01),


              DropdownButtonFormField <String>(
                value: report.category ,
                validator: ( value ) {
                  if ( value == null || value.isEmpty ){
                    return 'La categoria es requerido';
                  }
                },
                items: reportsService.categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    onTap: (){
                      report.category = value;
                    },
                    child: Text(value ),
                  );
                }).toList(),
                elevation: 1,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Categoria',
                ),
                onChanged: (value) {
                }
              ),


              SizedBox( height: size.height * 0.01),


              DropdownButtonFormField <String>(
                value: report.municipality ,
                validator: ( value ) {
                  if ( value == null || value.isEmpty ){
                    return 'La descripción es requerido';
                  }
                },
                items: instituteService.municipalities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    onTap: (){
                      /* Obetener colonias de este municipio */
                      colonyService.getColonyByMunicipality(value);
                      report.colony = null;
                      report.municipality = value;
                    },
                    child: Text(value ),
                    
                  );
                }).toList(),
                elevation: 1,
                // isExpanded: true,
                // value: 'A',
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Municipio',
                ),
                onChanged: (value) {
                }
              ),


              SizedBox( height: size.height * 0.01),

              if ( !colonyService.isLoading )
                colonyService.colonies.isNotEmpty ? DropdownButtonFormField <String>(
                  value: report.colony ,
                  validator: ( value ) {
                    if ( value == null || value.isEmpty ){
                      return 'La descripción es requerido';
                    }
                  },
                  items: colonyService.colonies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      onTap: (){
                        // report.colony = value;
                      },
                      child: Text(value ),
                    );
                  }).toList(),
                  elevation: 1,
                  // isExpanded: true,
                  // value: 'A',
                  decoration: InputDecorations.authInputDecoration(
                    labelText: 'Colonia',
                  ),
                  onChanged: ( value ) {
                    report.colony = value!;
                  },
                ): Container(),
              

              if ( colonyService.isLoading )
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),

              SizedBox( height: size.height * 0.02),

              MyButton(
                color: Color(0xFF7E57C2),
                text: 'Abrir mapa y añadir marcador',
                onPressed: () {

                  if ( report.id != null ) {
                    mapProvider.locationReport = LatLng(report.location!.lat, report.location!.lng);
                  } else {
                    mapProvider.locationReport = mapProvider.latLngUser;
                  }

                  Navigator.pushNamed(context, 'map');
                  
                },
              ),



              SwitchListTile.adaptive(
                value: report.anonymous,
                title: Text('Reportar anónimamente',
                  style: TextStyle(
                    color: Colors.black38
                  )
                ),
                activeColor: Color(0xFF7E57C2),
                onChanged: reportsForm.updateAnonymous
              ),

              

              SizedBox( height: size.height * 0.02),

            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only( bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,5),
        blurRadius: 3
      )
    ]
  );
}