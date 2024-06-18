import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lesson5/controller/home_controller.dart';
import 'package:lesson5/model/tictactoe_game_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/HomeScreen";

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  late HomeController con;
  late TicTacToeGame model;
  Map<Marking, Widget> images = {
    Marking.X: Image.asset("images/X.png"),
    Marking.O: Image.asset("images/O.png"),
    Marking.U: Image.asset("images/U.png"),
  };

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
      body: bodyView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: con.onPressedNewGame,
        child: const Icon(Icons.new_label_rounded),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    switch (model.state) {
      case GameState.init:
        return initScreen(context);
      case GameState.playing:
        return playingScreen(context);
      case GameState.over:
        return GameOverScreeen(context);
    }
  }

  Widget initScreen(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color.fromARGB(255, 255, 243, 201),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to TicTacTeo Game",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "Press <+> for new game",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  Widget playingScreen(BuildContext context) {
    return Column(
      children: [
        headerStatusRow(context),
        const SizedBox(
          height: 12,
        ),
        for (int r = 0; r < 3; r++) gameBoardRow(context, r),
      ],
    );
  }

  Widget gameBoardRow(BuildContext context, int r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int c = 0; c < 3; c++)
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 4,
            child: OutlinedButton(
              onPressed: model.state == GameState.playing &&
                      model.board[r * 3 + c] == Marking.U
                  ? () => con.onPressedButton(r * 3 + c)
                  : null,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 3,
                      color: Colors.blue
                    ),
                  ),
              child: images[model.board[r * 3 + c]],
            ),
          ),
      ],
    );
  }

  Widget headerStatusRow(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        Text(
          "Turn: ",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          width: 30,
          child: images[model.turn]!,
        ),
        Text(
          " (Moves=${model.moves})",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget GameOverScreeen(BuildContext context) {
    late String gameOverMessage;
    switch (model.winner) {
      case Marking.O:
        gameOverMessage = "Winner: O with ${model.moves} moves.";
        break;
      case Marking.X:
        gameOverMessage = "Winner: X with ${model.moves} moves.";
        break;
      case Marking.U:
        gameOverMessage = "Draw.";
      default:
    }

    gameOverMessage += "\nPress <+> for new game";

    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.green[100],
          child: Text(
            gameOverMessage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        headerStatusRow(context),
        for (int r = 0; r < 3; r++) gameBoardRow(context, r),
      ],
    );
  }
}
