
import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:idaipqroo/widgets/widgets.dart';
import 'package:provider/provider.dart';

class InstitutesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final idaipService = Provider.of<IdaipService>(context);
    final instititeService = Provider.of<InstituteService>(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if ( !idaipService.isLoading )

            _IdaipCard( idaipService.user ),

          if ( idaipService.isLoading )
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          

          

          ListMunicipalities(
                  municipality: instititeService.municipalities,
          ),
          
          if ( !instititeService.isLoading )
            Expanded(
              child: _ListInstitutes( institutes: instititeService.getInstitutes )
          ),

          if ( instititeService.isLoading )
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              )
          )

        ],
    );
  }

}

class _IdaipCard extends StatelessWidget {

  final User user;

  const _IdaipCard(this.user);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'admin', arguments: user),
      child: Padding(
      // padding: const EdgeInsets.all(15.0),
      padding: EdgeInsets.all( size.width * 0.04 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: size.width * 0.25,
              width: size.width * 0.25,
              child: FadeInImage(
                  image: NetworkImage( user.getImage() ),
                  placeholder: AssetImage('assets/images/loading.gif'),
                  fit: BoxFit.cover,
                ),
            ),
          ),

          SizedBox(
            width: size.width * 0.04,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( user.email.toUpperCase(), 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text( user.name , 
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),

          SizedBox(
            width: size.width * 0.04,
          ),

          const Icon ( Icons.arrow_forward_ios_rounded, size: 18, color: Colors.black45 )

        ],
      ),
    ),
          );
  }
}

class _ListInstitutes extends StatelessWidget {

  final List<Institute>? institutes;

  const _ListInstitutes({ this.institutes});

  @override
  Widget build(BuildContext context) => institutes!.isNotEmpty 
    ? Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10
      ),
      child: ListView.builder(
        itemCount: institutes?.length,
        itemBuilder: (BuildContext context, int i ) {
          return _InstituteItem(
            institute: institutes![i],
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

class _InstituteItem extends StatelessWidget {

  final Institute institute;

  const _InstituteItem({ required this.institute});



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, 'institute', arguments: institute ),
      child: Container(
        decoration: _cardDecoration(),
        height: size.height * 0.2,
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: size.width * 0.35,
                width: size.width * 0.35,
                child: FadeInImage(
                    image: NetworkImage( institute.getImage() ),
                    placeholder: AssetImage('assets/images/loading.gif'),
                    fit: BoxFit.cover,
                  ),
              ),
            ),

            SizedBox(
              width: size.width * 0.03,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text( institute.name ,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),

                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  Text( institute.description ,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 4,
                  ),

                ],
              ),
            )

          ]
        )
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


