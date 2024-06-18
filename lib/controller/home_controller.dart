import 'package:lesson5/View/home_Screen.dart';
import 'package:lesson5/model/tictactoe_game_model.dart';

class HomeController{
  HomeState state;
  HomeController(this.state);

  void onPressedNewGame(){
    state.callSetState((){
      state.model.restart();
    });
  }

  void onPressedButton(int index){
    state.callSetState((){
      state.model.board[index] = state.model.turn;
      state.model.changeTurns();
      state.model.setWinner();
      if(state.model.winner != null){
        state.model.state =GameState.over;
      }
    });
  }
}

