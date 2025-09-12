import 'package:flutter/material.dart';

class PickSide extends StatefulWidget {
  const PickSide({super.key});

  @override
  State<PickSide> createState() => _PickSideState();
}

class _PickSideState extends State<PickSide> {
  String? selectedPlayer; // اللاعب المختار (X أو O)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ العنوان
            const Text(
              "Choose your player",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // ✅ زرين (X و O)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPlayerButton("X", Color.fromARGB(255, 201, 34, 23)),
                const SizedBox(width: 40),
                _buildPlayerButton("O", Color.fromARGB(255, 123, 64, 64)),
              ],
            ),

            const SizedBox(height: 60),

            // ✅ زر Start
            selectedPlayer == null
                ? const SizedBox.shrink() // عنصر فاضي يعني الزر مختفي
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/game",
                        arguments: selectedPlayer,
                      );
                    },
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
                          "START",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget لزر اللاعب (X أو O)
  Widget _buildPlayerButton(String player, Color color) {
    bool isSelected = selectedPlayer == player;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlayer = player;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? color.withOpacity(0.8) : Colors.grey[200],
          border: Border.all(color: color, width: 3),
        ),
        child: Center(
          child: Text(
            player,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}
