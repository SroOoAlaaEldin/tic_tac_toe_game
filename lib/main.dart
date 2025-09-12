import 'package:flutter/material.dart';
import 'package:x_o_apps/game_screen.dart';
import 'package:x_o_apps/home.dart';
import 'package:x_o_apps/pick_side.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/", // أول شاشة
      routes: {
        "/": (context) => const Home(),
        "/choose": (context) => const PickSide(),
        "/game": (context) {
          // ناخد اللاعب المختار
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return GameScreen(player: args);
        },
      },
    );
  }
}
