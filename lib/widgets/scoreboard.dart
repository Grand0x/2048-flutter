import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("2048", 
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48, 
            color: Colors.white),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10.0), // Padding à l'intérieur du Container
            decoration: BoxDecoration(
              color: Colors.purple[400], // Couleur de fond
              borderRadius: BorderRadius.circular(12.0), // Coins arrondis
            ),
            child: const Center(
              child: Text(
                'Score: 0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0, // Taille du texte
                  color: Colors.white, // Couleur du texte
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}