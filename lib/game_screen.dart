import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameScreen extends StatefulWidget {
  String player;
  GameScreen({super.key, required this.player});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";
  String winner = "";
  @override
  void initState() {
    super.initState();
    currentPlayer = widget.player; // أول لاعب هو المختار
  }

  void _handleTap(int index) {
    if (board[index] == "" && winner == "") {
      setState(() {
        board[index] = currentPlayer;
        _checkWinner();
        if (winner == "") {
          currentPlayer = (currentPlayer == "X") ? "O" : "X";
        }
      });
    }
  }

  void _checkWinner() {
    List<List<int>> winPatter = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var pattern in winPatter) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];

      if (a != "" && a == b && b == c) {
        winner = a;
        break;
      }
    }
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, "");
      winner = "";
      currentPlayer = widget.player;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text("Tic Tac Toe"),
      //   backgroundColor: Colors.pink,
      //   centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ✅ حالة اللعبة
          Text(
            winner.isNotEmpty
                ? "🎉 Winner: $winner 🎉"
                : "Turn: $currentPlayer",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // ✅ الشبكة 3×3
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: board[index] == "X"
                              ? Color.fromARGB(255, 201, 34, 23)
                              : Color.fromARGB(255, 123, 64, 64),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ✅ زر إعادة التشغيل
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: _resetGame,
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 201, 34, 23),
                    Color.fromARGB(255, 123, 64, 64),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "Restart Game",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
