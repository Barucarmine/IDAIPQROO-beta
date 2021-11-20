

import 'package:flutter/material.dart';
import 'package:idaipqroo/screens/screens.dart';

class MyReportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mis reportes'),
          bottom: TabBar(
              tabs: [
                Tab( text: 'Actuales'),
                Tab( text: 'Pendientes'),
              ],
            ),
        ),
         body: TabBarView(
            children: [
              MyServicesScreen(),
              ReportsPendientesScreen()
            ],
          ),
      ),
    );
  }

}