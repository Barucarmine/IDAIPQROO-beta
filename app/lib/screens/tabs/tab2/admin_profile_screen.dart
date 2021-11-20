


import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';
import 'package:idaipqroo/utils/utils.dart';


class AdminProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context)!.settings.arguments as User;
    final size = MediaQuery.of(context).size;
    
    final idaipService = Provider.of<IdaipService>(context);

    return Scaffold(

      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [

          _CustomAppBar( user ),

          SliverList(
            delegate: SliverChildListDelegate([

              SizedBox(
                height: size.width * 0.05,
              ),

              Container(
                padding: EdgeInsets.all( size.width * 0.03),
                child: Text( user.name ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                    textAlign: TextAlign.center),
              ),

              _SocialNetworks(),

              _Overview( user ),
              _Overview( user ),

              SizedBox(
                height: size.width * 0.03,
              ),

              FutureBuilder(
                future: idaipService.getEvents(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot ){
              
                  if ( !snapshot.hasData ){
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    );
                  } else {
                    return _CustomEvents( 'Eventos', snapshot.data );
                  }

                } ,
              ),


              SizedBox(
                height: size.width * 0.05,
              ),

              // _CustomEvents( 'Conmemoraciones' ),

              SizedBox(
                height: size.width * 0.05,
              ),


            ]),
          )

        ],
      )
    );
  }

}

class _CustomEvents extends StatelessWidget {
 
  final String title;
  final List<Event> events;

  _CustomEvents( this.title, this.events );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.03
          ),
          child: Text( title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
        ),

        SizedBox(
          height: size.width * 0.03,
        ),

        SizedBox(
          height: size.height * 0.28,
          child: _ListEvents( events )
        )
      ],
    );
  }
}


class _CustomAppBar extends StatelessWidget {

  final User user;

  const _CustomAppBar( this.user );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
        backgroundColor: Colors.deepPurple,
        expandedHeight: size.height * 0.27,
        floating: false,
        pinned: true,
        actions: [
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon( Icons.chat_rounded ),
            onPressed: () => Navigator.pushNamed(context, 'chat'),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          centerTitle: true,
          title: Container(
              width: double.infinity,
              color: Colors.black12,
              padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
              alignment: Alignment.bottomCenter,
              child: Text( user.email , 
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          background: FadeInImage(
              placeholder: AssetImage('assets/images/loading.gif'),
              image: NetworkImage( user.getImage() ),
              fit: BoxFit.cover),
        ));
  }
}


class _Overview extends StatelessWidget {

  final User user;

  const _Overview( this.user );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all( size.width * 0.03),
      child: Text( user.description! ,
          textAlign: TextAlign.justify),
    );
  }
}



class _ListEvents extends StatelessWidget {

  final List<Event> events;

  _ListEvents( this.events );

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemBuilder: (BuildContext context, int i){
        return Container(
          // height: size.height * 0.30,
          width: size.width * 0.6,
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10
          ),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              _Image( events[i] ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text( events[i].title ,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        );
      },
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

class _Image extends StatelessWidget {

  final Event event;

  const _Image( this.event );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius:  BorderRadius.only( topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
            child: FadeInImage(
              image: NetworkImage( event.getImage() ),
              placeholder: AssetImage('assets/images/loading.gif'),
              height: size.height * 0.17,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: 0,
          right: 0,
          child: _DateTag( event )
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: _HourTag( event )
        ),

      ],
    );
  }
}


class _DateTag extends StatelessWidget {

  final Event event;

  _DateTag( this.event );

  @override
  Widget build(BuildContext context) {

    print( event.date );

    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text( '${event.date}' ,
            style: TextStyle(
              color: Colors.white
            ),
            ),
          ),
        ),
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.only( topRight: Radius.circular(10), bottomLeft: Radius.circular(10) )
      ),
    );
  }
}



class _HourTag extends StatelessWidget {

  final Event event;
  
  _HourTag( this.event );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            '${event.hour}',
            textAlign: TextAlign.right,
            style: TextStyle( color: Colors.red, fontSize: 14,),
          ),
        ),
      ),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }
}




class _SocialNetworks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: const FaIcon(FontAwesomeIcons.facebook, color: Color(0xff2D88FF), ),
          onPressed: () => Util.launchUrl(context, 'https://www.facebook.com/idaipqroo/'),
        ),
        IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: const FaIcon(FontAwesomeIcons.twitter, color: Color(0xff1D9BF0) ),
          onPressed: () => Util.launchUrl(context, 'https://twitter.com/IDAIPQRoo'),
        ),
        IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: const FaIcon(FontAwesomeIcons.chrome, color: Color(0xffBB306B) ),
          onPressed: () => Util.launchUrl(context, 'http://www.idaipqroo.org.mx/'),
        ),
      ],
    );
  }

}