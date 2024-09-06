import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: number == 0 ? Colors.grey[300] : Colors.orange[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          number == 0 ? '' : '$number',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}