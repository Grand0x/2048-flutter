import 'dart:math';

import 'package:flutter/material.dart';

class Grid extends ChangeNotifier {
  late List<List<int>> _grid; // Grille 4x4
  late int _score;

  Grid() {
    _grid = List.generate(4, (_) => List.generate(4, (_) => 0)); // Grille vide
    _score = 0;
    _addRandomTile(); // Ajout d'une tuile au départ
    _addRandomTile(); // Ajout d'une autre tuile
  }

  // Accesseurs pour la grille et le score
  List<List<int>> get grid => _grid;
  int get score => _score;

  // Méthode pour ajouter une tuile aléatoire (2 ou 4) dans une case vide
  void _addRandomTile() {
    List<Point<int>> emptyTiles = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          emptyTiles.add(Point(i, j));
        }
      }
    }

    if (emptyTiles.isNotEmpty) {
      Point<int> randomTile = emptyTiles[Random().nextInt(emptyTiles.length)];
      _grid[randomTile.x][randomTile.y] =
          Random().nextBool() ? 2 : 4; // Ajoute 2 ou 4
      notifyListeners(); // Notifie les widgets dépendants
    }
  }

  // Méthode pour réinitialiser le jeu
  void resetGame() {
    _grid = List.generate(4, (_) => List.generate(4, (_) => 0));
    _score = 0;
    _addRandomTile();
    _addRandomTile();
    notifyListeners();
  }

  // Méthode pour mettre à jour le score lors d'une fusion
  void updateScore(int points) {
    _score += points;
    notifyListeners();
  }
}
