import 'package:flutter/material.dart';

class BingoItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color cardColor;
  const BingoItem(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
