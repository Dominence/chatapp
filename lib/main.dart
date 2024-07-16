import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnfirebase/screens/login_page.dart';
import 'package:learnfirebase/utils/app_route.dart';
import 'package:learnfirebase/utils/setup.dart';

import 'Services/auth_service.dart';
import 'Services/navigation_service.dart';


void main() async {
  await setup();
  runApp( MyApp());
}
Future<void> setup() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  late AuthService _authService;
   MyApp({super.key}){
     _navigationService = _getIt.get<NavigationService>();
     _authService = _getIt.get<AuthService>();
   }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorkey,
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Decco',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: _navigationService.routes,
      initialRoute: _authService.user != null ? "/home" : "/login",
    );
  }
}

