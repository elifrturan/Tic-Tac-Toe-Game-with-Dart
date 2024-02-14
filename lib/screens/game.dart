import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  bool oTurn = true;
  List<String> displayX0 = ["","","","","","","","",""];
  List<int> matchesIndex = [];

  String resultDecoration = "";
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  int attempts = 0;

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  void StartTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if(seconds > 0){
          seconds--;
        }else{
          StopTimer();
        }
      });
    });
  }

  void StopTimer(){
    ResetTimer();
    timer?.cancel();
  }

  void ResetTimer(){
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text("Player O", style: customFontWhite,),
                         Text(oScore.toString(), style: customFontWhite,)
                       ],
                    ),
                    SizedBox(width: 25,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Player X", style: customFontWhite,),
                        Text(xScore.toString(), style: customFontWhite,)
                      ],
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: MainColor.primaryColor,
                          ),
                          color: matchesIndex.contains(index)
                              ? MainColor.accentColor
                              : MainColor.secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            displayX0[index],
                            style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                fontSize: 60,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
              }),
              flex: 5,
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultDecoration, style: customFontWhite,),
                    buildTimer(),
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      )
    );
  }
  void _tapped(int index){
    final isRunning = timer == null ? false : timer!.isActive;

    if(isRunning) {
      setState(() {
        if (oTurn && displayX0[index] == "") {
          displayX0[index] = "O";
          filledBoxes++;
        } else if (!oTurn && displayX0[index] == "") {
          displayX0[index] = "X";
          filledBoxes++;
        }
        oTurn = !oTurn;
        checkWinner();
      });
    }
  }

  void checkWinner(){
    if(displayX0[0] == displayX0[1]
        && displayX0[0] == displayX0[2]
        && displayX0[0] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[0] + " Winner!";
        matchesIndex.addAll([0, 1, 2]);
        StopTimer();
        updateScore(displayX0[0]);
      });
    }

    if(displayX0[3] == displayX0[4]
        && displayX0[3] == displayX0[5]
        && displayX0[3] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[3] + " Winner!";
        matchesIndex.addAll([3, 4, 5]);
        StopTimer();
        updateScore(displayX0[3]);
      });
    }

    if(displayX0[6] == displayX0[7]
        && displayX0[6] == displayX0[8]
        && displayX0[6] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[6] + " Winner!";
        matchesIndex.addAll([6, 7, 8]);
        StopTimer();
        updateScore(displayX0[6]);
      });
    }

    if(displayX0[0] == displayX0[3]
        && displayX0[0] == displayX0[6]
        && displayX0[0] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[0] + " Winner!";
        matchesIndex.addAll([0, 3, 6]);
        StopTimer();
        updateScore(displayX0[0]);
      });
    }

    if(displayX0[1] == displayX0[4]
        && displayX0[1] == displayX0[7]
        && displayX0[1] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[1] + " Winner!";
        matchesIndex.addAll([1, 4, 7]);
        StopTimer();
        updateScore(displayX0[1]);
      });
    }

    if(displayX0[2] == displayX0[5]
        && displayX0[2] == displayX0[8]
        && displayX0[2] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[2] + " Winner!";
        matchesIndex.addAll([2, 5, 8]);
        StopTimer();
        updateScore(displayX0[2]);
      });
    }

    if(displayX0[0] == displayX0[4]
        && displayX0[0] == displayX0[8]
        && displayX0[0] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[0] + " Winner!";
        matchesIndex.addAll([0, 4, 8]);
        StopTimer();
        updateScore(displayX0[0]);
      });
    }

    if(displayX0[2] == displayX0[4]
        && displayX0[2] == displayX0[6]
        && displayX0[2] != ""){

      setState(() {
        resultDecoration = "Player " + displayX0[2] + " Winner!";
        matchesIndex.addAll([2, 4, 6]);
        StopTimer();
        updateScore(displayX0[2]);
      });
    }

    if(!winnerFound && filledBoxes == 9){
      setState(() {
        resultDecoration = "Nobody Wins!";
      });
    }
  }

  void updateScore(String winner){
    if(winner == "O"){
      oScore++;
    }
    else if(winner == "X"){
      xScore++;
    }
    winnerFound = true;
  }

  void clearBoard(){
    setState(() {
      for(int i = 0; i < 9; i++){
        displayX0[i] = "";
      }
      resultDecoration = "";
    });
    filledBoxes = 0;
  }

  Widget buildTimer(){
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: Colors.orange,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        :  Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
            width: 180,
            height: 50,
            child: ElevatedButton(
              child: Text(
                attempts == 0 ? "Start" :  "Play Again!",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: (){
                StartTimer();
                clearBoard();
                attempts++;
              },
            ),
          ),
        );
  }
}
