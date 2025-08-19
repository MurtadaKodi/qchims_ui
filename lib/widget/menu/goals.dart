import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Constants.kDefaultPadding),
          child: Text('Explore Historical Sites', style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.lerp(FontWeight.normal, FontWeight.bold, 0.5),
            color: Colors.white,
          ) ),
        ),
        buildGoals(text: 'Alzubara'),
        buildGoals(text: 'Villages'),
        buildGoals(text: 'Towers'),
        buildGoals(text: 'Forts'),
      ],
    );
  }

  Padding buildGoals({required String text}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: Constants.kDefaultPadding / 2),
        child: Row(
          children: [
            Icon(Icons.check, color: const Color.fromARGB(255, 172, 158, 151), size: 22),
            SizedBox(width: Constants.kDefaultPadding / 2),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 172, 158, 151),
                ),
              ),
            ),
          ],
        ),
      );
  }
}