import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({super.key, required this.number});

  final int number;

  Color getTileColor(int nb) {
    if (nb >= 1024) {
      return const Color(0xFFEB3B58);
    } else if (nb >= 128) {
      return const Color(0xFF7C86E9);
    } else if (nb >= 64) {
      return const Color.fromARGB(255, 4, 143, 207);
    } else if (nb >= 32) {
      return const Color(0xFF00B0FF);
    } else if (nb >= 16) {
      return const Color.fromARGB(255, 45, 169, 180);
    } else if (nb >= 8) {
      return const Color(0xFF3CD2E0);
    } else if (nb >= 4) {
      return const Color.fromARGB(255, 123, 226, 221);
    } else if (nb >= 2) {
      return const Color(0xFFA1E6E3);
    }
    return const Color.fromARGB(71, 224, 224, 224);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getTileColor(number),
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
