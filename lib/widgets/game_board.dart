import 'package:flutter/material.dart';
import 'package:myapp/models/grid.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key, required this.grid});

  final Grid grid;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[400], // Couleur de fond
        borderRadius: BorderRadius.circular(12.0), // Coins arrondis
      ),
      child: null,
    );
  }
}
