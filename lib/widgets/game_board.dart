import 'package:flutter/material.dart';
import 'package:myapp/models/grid.dart';
import 'package:myapp/widgets/tile.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key, required this.grid});

  final Grid grid;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // Fonction pour capturer les gestes de swipe et déplacer les tuiles
  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity != null) {
      if (details.primaryVelocity! < 0) {
        // Swipe vers la gauche
        widget.grid.moveLeft();
      } else if (details.primaryVelocity! > 0) {
        // Swipe vers la droite
        widget.grid.moveRight();
      }
    } else if (details.velocity.pixelsPerSecond.dy != 0) {
      if (details.velocity.pixelsPerSecond.dy < 0) {
        // Swipe vers le haut
        widget.grid.moveUp();
      } else {
        // Swipe vers le bas
        widget.grid.moveDown();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _handleSwipe,
      onVerticalDragEnd: _handleSwipe,
      child: Column(
        children: [
          Expanded(
              child: ListenableBuilder(
                  listenable: widget.grid,
                  builder: (context, child) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: 16,
                      itemBuilder: (context, index) {
                        int row = index ~/ 4;
                        int col = index % 4;
                        return Tile(number: widget.grid.grid[row][col]);
                      },
                    );
                  })),
        ],
      ),
    );
  }
}
