import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;

  const CardWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 217, 214, 214),
            blurRadius: 64,
          )
        ],
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.wallet),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            Text(
              amount,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
