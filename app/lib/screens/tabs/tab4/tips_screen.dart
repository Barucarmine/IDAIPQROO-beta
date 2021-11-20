

import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';

class TipsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final tipsService = Provider.of<TipsService>(context);
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
          child: Text('¿Sabías qué...?',
            style: TextStyle(
              fontSize: size.height * 0.03
            )
          ),
        ),

        FutureBuilder(
          future: tipsService.getTips(),
          builder: (BuildContext context,  AsyncSnapshot<List<Tip>> snapshot ) {

            if ( snapshot.hasData ) {

              return Expanded(child: _ListTips( snapshot.data! ));

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


class _ListTips extends StatelessWidget {

  List<Tip> tips;

  _ListTips( this.tips );

  @override
  Widget build(BuildContext context) => ( tips.isEmpty ) 
          ? Center(
            child: Text('vacío', 
              style: TextStyle( 
                  color: Colors.grey[400] 
              ) 
            ),
          )
          : ListView.separated(
            itemBuilder: ( context, i) => _ItemListTile( tips[i], i ),
            separatorBuilder: (_, i) => const Divider(),
            itemCount: tips.length
          );
}


class _ItemListTile extends StatelessWidget {

  final Tip tip;
  final int i;

  _ItemListTile( this.tip, this.i );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text( tip.text,
        textAlign: TextAlign.justify,
      ),
      leading: Text( '${i+1}',
        style: TextStyle(
          fontSize: 20
        ),
      ),
    );
  }
}
