import 'package:flutter/material.dart';
import 'package:idaipqroo/models/institute.dart';

class InstituteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Institute institute = ModalRoute.of(context)!.settings.arguments as Institute;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          _CustomAppBar( institute ),

          SliverList(
            delegate: SliverChildListDelegate([

              Container(
                padding: EdgeInsets.all( size.width * 0.03),
                child: Text( institute.name ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                    textAlign: TextAlign.center),
              ),

              _Overview( institute ),
              _Overview( institute ),

              _CustomDatos( institute )


            ]),
          )

        ],
      )
    );
  }

}


class _CustomAppBar extends StatelessWidget {

  final Institute institute;

  const _CustomAppBar( this.institute );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
        backgroundColor: Colors.purple,
        expandedHeight: size.height * 0.27,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          centerTitle: true,
          title: Container(
              width: double.infinity,
              color: Colors.black12,
              padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
              alignment: Alignment.bottomCenter,
              /* child: Text( institute.name, 
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ) */),
          background: FadeInImage(
              placeholder: AssetImage('assets/images/loading.gif'),
              image: NetworkImage( institute.getImage() ),
              fit: BoxFit.cover),
        ));
  }
}


class _Overview extends StatelessWidget {

  final Institute institute;

  const _Overview( this.institute );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all( size.width * 0.03),
      child: Text( institute.description ,
          textAlign: TextAlign.justify),
    );
  }
}



class _CustomDatos extends StatelessWidget {

  final Institute institute;

  const _CustomDatos( this.institute );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        _CustomInfo('Encargado:', institute.manager ),
        _CustomInfo('Municipio:', institute.municipality ),
        _CustomInfo('Dirección', institute.adress ),
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
