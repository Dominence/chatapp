import 'package:flutter/material.dart';
import 'package:learnfirebase/screens/home_page.dart';
import 'package:learnfirebase/screens/login_page.dart';
import 'package:path/path.dart';

class NavigationService{
 late GlobalKey<NavigatorState> _navigatorkey;

 final Map<String,Widget Function(BuildContext)> _routes ={
  "/login" : (context) => LoginPage(),
  "/home" : (context) => HomePage(),
 };

 GlobalKey<NavigatorState>? get navigatorkey{
  return _navigatorkey;
 }

 Map<String,Widget Function(BuildContext)> get routes{
  return _routes;
 }

 NavigationService(){
  _navigatorkey = GlobalKey<NavigatorState>();
 }

 void pushNamed(String routeName){
  _navigatorkey.currentState?.pushNamed(routeName);
 }

 void pushReplacementNamed(String routeName){
  _navigatorkey.currentState?.pushReplacementNamed(routeName);
 }

 void goBack(){
  _navigatorkey.currentState?.pop();
 }
}