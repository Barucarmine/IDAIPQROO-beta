


import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';

class SearchReports extends SearchDelegate {


  @override
  String? get searchFieldLabel => 'Buscar...';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () => this.query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon( Icons.arrow_back ),
      onPressed: () => this.close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if ( query.trim().length == 0 ) {
      return Center(child: Text('Ingrese un valor a buscar'));
    }

    final searchService = Provider.of<SearchService>(context, listen: false);

    return FutureBuilder(
      future: searchService.getServiceByTermino( query.trim() ),
      builder: (BuildContext context, AsyncSnapshot<List<Service>> snapshot ){
        
        if ( snapshot.hasData ) {

          if ( snapshot.data!.isEmpty ){
            return Center(child: Text('No hay resultados para ${query.trim()}'));
          }

          return _ListResults( services: snapshot.data! );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          );
        }

      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final searchService = Provider.of<SearchService>(context, listen: false);

    if ( searchService.historial.isEmpty ){
      return Center(
        child: Text('Historial vacio', style: TextStyle( color: Colors.black38 )),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Historial'),
        ),

        Expanded(child: _ListResults( services: searchService.historial )),
      ],
    );

  }


}



class _ListResults extends StatelessWidget {

  final List<Service> services;

  const _ListResults({required this.services });

  @override
  Widget build(BuildContext context) {


    return ListView.separated(
      itemCount: services.length,
      separatorBuilder: (_, i) => const Divider(),
      itemBuilder: (_, i) {

        return _Result(
          service: services[i],
          onTap: (){}
        );

      },
    );
  }
}


class _Result extends StatelessWidget {

  final Service service;
  final Function onTap;

  const _Result({ required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {

    final searchService = Provider.of<SearchService>(context);
    final servicioService = Provider.of<ServicioService>(context);


    return ListTile(
          leading: FadeInImage(
            image: NetworkImage( service.report.getImage() ),
            placeholder: AssetImage('assets/images/loading.gif'),
            fit: BoxFit.contain,
            width: 50,
          ),
          title: Text(service.report.title),
          subtitle: Text(service.report.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
          onTap: () {
            searchService.addHostorial(service);
            // HAcer navegación
            servicioService.serviceSelected = service;
            // Navigator.pushNamed(context, 'service', arguments: service );
            Navigator.pushNamed(context, 'service' );

          
          }
        );
  }
}