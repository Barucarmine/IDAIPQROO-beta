


import 'package:flutter/cupertino.dart';
import 'package:idaipqroo/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'about'    : (_) => AboutScreen(),
  'admin'    : (_) => AdminProfileScreen(),
  'chat'     : (_) => ChatScreen(),
  'help'     : (_) => HelpScreen(),
  'home'     : (_) => HomeScreen(),
  'institute': (_) => InstituteScreen(),
  'map'      : (_) => MapScreen(),
  'myReports': (_) => MyReportsScreen(),
  'loading'  : (_) => LoadingScreen(),
  'login'    : (_) => LoginScreen(),
  'register' : (_) => RegisterScreen(),
  'report'   : (_) => ReportScreen(),
  'service'   : (_) => ServiceScreen(),
};