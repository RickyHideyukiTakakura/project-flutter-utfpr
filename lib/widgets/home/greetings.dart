import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  final String name;

  const Greetings({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 20,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Hello, '),
            TextSpan(
              text: name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[100]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
