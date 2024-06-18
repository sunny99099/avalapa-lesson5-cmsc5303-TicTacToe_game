import 'package:flutter/material.dart';

import 'View/home_Screen.dart';

void main(){
  runApp(const TicTacTorApp());
}

class TicTacTorApp extends StatelessWidget{
  const TicTacTorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,

      ) ,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }

}