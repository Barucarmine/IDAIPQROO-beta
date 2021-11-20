

import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 15,
            bottom: 15
          ),
          child: Text('Novedades',
            style: TextStyle(
              fontSize: size.height * 0.03
            )
          ),
        ),

        FutureBuilder(
          future: newsService.getNews(),
          builder: (BuildContext context,  AsyncSnapshot<List<New>> snapshot ) {

            if ( snapshot.hasData ) {

              return Expanded(child: _ListNews( snapshot.data! ));

            } else {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              );
            }

          },
        ),
      ],
    );
  }

}


class _ListNews extends StatelessWidget {

  List<New> news;

  _ListNews( this.news );

  @override
  Widget build(BuildContext context) => ( news.isEmpty ) 
          ? Center(
            child: Text('vacío', 
              style: TextStyle( 
                  color: Colors.grey[400] 
              ) 
            ),
          )
          : ListView.builder(
            itemCount: news.length,
            itemBuilder: (BuildContext context, int i) {
              return _NewItem( news[i] );
            },
          );
}

class _NewItem extends StatelessWidget {
  
  final New newItem;

  _NewItem( this.newItem );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        print( 'NAVEGAR A NEW PAGE' );
      },
      child: Container(
        height: size.height * 0.5,
        margin: const EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: 15
        ),
        decoration: _cardDecoration(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Opacity(
              opacity: 0.9,
              child: ClipRRect(
                borderRadius:  BorderRadius.only( topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
                child: FadeInImage(
                  image: NetworkImage( newItem.getImage() ),
                  placeholder: AssetImage('assets/images/loading.gif'),
                  height: size.height * 0.29,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(
              width: size.width * 0.03,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( newItem.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox( height: size.height * 0.01 ),
                  Text( newItem.subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox( height: size.height * 0.01 ),

                  Text( newItem.content,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox( height: size.height * 0.01 ),

                  Text( newItem.createdAt.toLocal().toString().split(" ")[0],
                    style: TextStyle(
                      color: Colors.red[400]
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration()  => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 3,
        offset: Offset(0, 5),
      )
    ]
  );

}