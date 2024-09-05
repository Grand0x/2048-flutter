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
  void _updateScore(int points) {
    _score += points;
    notifyListeners();
  }

  // Méthode pour vérifier si le jeu est terminé (aucun mouvement possible)
  bool isGameOver() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) return false; // Il reste une case vide
        if (i > 0 && _grid[i][j] == _grid[i - 1][j]) return false; // Fusion possible en haut
        if (i < 3 && _grid[i][j] == _grid[i + 1][j]) return false; // Fusion possible en bas
        if (j > 0 && _grid[i][j] == _grid[i][j - 1]) return false; // Fusion possible à gauche
        if (j < 3 && _grid[i][j] == _grid[i][j + 1]) return false; // Fusion possible à droite
      }
    }
    return true; // Aucune case vide et aucune fusion possible
  }

  // Méthode pour déplacer et fusionner les tuiles dans une direction donnée
  void moveLeft() {
    for (int i = 0; i < 4; i++) {
      _grid[i] = _slideAndMergeRow(_grid[i]);
    }
    _addRandomTile();
    notifyListeners();
  }

  void moveRight() {
    for (int i = 0; i < 4; i++) {
      _grid[i] = _slideAndMergeRow(_grid[i].reversed.toList()).reversed.toList();
    }
    _addRandomTile();
    notifyListeners();
  }

  void moveUp() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [_grid[0][j], _grid[1][j], _grid[2][j], _grid[3][j]];
      column = _slideAndMergeRow(column);
      for (int i = 0; i < 4; i++) {
        _grid[i][j] = column[i];
      }
    }
    _addRandomTile();
    notifyListeners();
  }

  void moveDown() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [_grid[0][j], _grid[1][j], _grid[2][j], _grid[3][j]];
      column = _slideAndMergeRow(column.reversed.toList()).reversed.toList();
      for (int i = 0; i < 4; i++) {
        _grid[i][j] = column[i];
      }
    }
    _addRandomTile();
    notifyListeners();
  }

  // Fonction utilitaire pour glisser et fusionner une rangée
  List<int> _slideAndMergeRow(List<int> row) {
    List<int> newRow = row.where((val) => val != 0).toList(); // Supprime les zéros
    for (int i = 0; i < newRow.length - 1; i++) {
      if (newRow[i] == newRow[i + 1]) {
        newRow[i] *= 2; // Fusion des tuiles
        _updateScore(newRow[i]); // Mise à jour du score
        newRow[i + 1] = 0; // Remplacer la tuile fusionnée par un zéro
      }
    }
    newRow.removeWhere((val) => val == 0); // Supprime les zéros
    while (newRow.length < 4) {
      newRow.add(0); // Complète avec des zéros à droite
    }
    return newRow;
  }
}
