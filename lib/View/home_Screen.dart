import 'package:flutter/material.dart';
import 'package:lesson5/controller/home_controller.dart';
import 'package:lesson5/model/tictactoe_game_model.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  static const routeName = "/HomeScreen";

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}

class HomeState extends State<HomeScreen>{
  late HomeController con;
  late TicTacToeGame model;

  @override
  void initState() {
    super.initState();
    con = HomeController(this);
    model = TicTacToeGame();
  }

  void callSetState(fn) => setState(fn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Play TicTacTow"),
      ),
      body: const Text("GAME"),
    );
  }

}