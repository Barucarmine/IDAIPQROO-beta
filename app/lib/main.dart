

import 'package:flutter/material.dart';
import 'package:idaipqroo/providers/providers.dart';
import 'package:idaipqroo/services/institute_service.dart';
import 'package:provider/provider.dart';
import 'package:idaipqroo/routes/routes.dart';
import 'package:idaipqroo/services/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService() ),
        ChangeNotifierProvider(create: (_) => SocketProvider() ),
        ChangeNotifierProvider(create: (_) => MapProvider() ),
        ChangeNotifierProvider(create: (_) => ChatService() ),
        ChangeNotifierProvider(create: (_) => ReportsService() ),
        ChangeNotifierProvider(create: (_) => UserReportsService() ),
        ChangeNotifierProvider(create: (_) => ReportFormProvider() ),
        ChangeNotifierProvider(create: (_) => InstituteService() ),
        ChangeNotifierProvider(create: (_) => SearchService() ),
        ChangeNotifierProvider(create: (_) => IdaipService() ),
        ChangeNotifierProvider(create: (_) => ServicioService() ),
        ChangeNotifierProvider(create: (_) => NewsService() ),
        ChangeNotifierProvider(create: (_) => TipsService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meet IDAIPQROO',
        initialRoute: 'loading',
        routes: appRoutes,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.deepPurple,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.deepPurple,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor:  Colors.deepPurple,
            ),
          ),
      ),
    );
  }
}