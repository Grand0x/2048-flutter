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
    final velocity = details.velocity.pixelsPerSecond;

    // Seuil de vélocité pour détecter un swipe
    const threshold = 20.0;

    if (velocity.dx.abs() > velocity.dy.abs()) {
      // Swipe horizontal
      if (velocity.dx < -threshold) {
        // Swipe gauche
        widget.grid.moveLeft();
      } else if (velocity.dx > threshold) {
        // Swipe droite
        widget.grid.moveRight();
      }
    } else {
      // Swipe vertical
      if (velocity.dy < -threshold) {
        // Swipe haut
        widget.grid.moveUp();
      } else if (velocity.dy > threshold) {
        // Swipe bas
        widget.grid.moveDown();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanEnd: _handleSwipe,
        child: ListenableBuilder(
            listenable: widget.grid,
            builder: (context, child) {
              return Stack(children: [
                Column(
                  children: [
                    Expanded(
                        child: Center(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        shrinkWrap: true,
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
                      ),
                    )),
                  ],
                ),
                if (widget.grid.isGameOver())
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Game Over',
                          style: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ]);
            }));
  }
}
