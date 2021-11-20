

import 'package:flutter/material.dart';
import 'package:idaipqroo/screens/screens.dart';
import 'package:idaipqroo/search/search_reports.dart';

class HomeScreen extends StatelessWidget   {

  final int? tab;

  HomeScreen( { this.tab });

  @override
  Widget build(BuildContext context) {

  
    return DefaultTabController(
      length: 5,
      initialIndex: tab != null ? tab! : 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meet IDAIPQROO'),
          bottom: TabBar(
            indicatorColor: Colors.deepPurple[300],
            tabs: [
              Tab( icon: Icon( Icons.home_outlined ) ),
              Tab( icon: Icon( Icons.business_outlined ) ),
              Tab( icon: Icon( Icons.note_alt_outlined ) ),
              Tab( icon: Icon( Icons.wb_incandescent_outlined  ) ),
              Tab( icon: Icon( Icons.menu ) ),
            ],
          ),
          actions: [
            IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon( Icons.search ),
              onPressed: (){
                showSearch(context: context, delegate: SearchReports() );
              },
            ),
            IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon( Icons.chat_rounded ),
              onPressed: () => Navigator.pushNamed(context, 'chat'),
            )
          ],
        ),
        body: TabBarView(
          children: [
            NewsScreen(),
            InstitutesScreen(),
            ReportsScreen(),
            TipsScreen(),
            MenuScreen()
          ],
        ),
        /* floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: const Text('Approve'),
          icon: const Icon(Icons.thumb_up),
          backgroundColor: Colors.purple,
        ), */
      ),
    );
  }
}