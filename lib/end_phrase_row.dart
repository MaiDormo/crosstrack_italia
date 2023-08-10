import 'package:flutter/material.dart';

class EndPhraseRow extends StatelessWidget {
  const EndPhraseRow({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onPressed,
  });
  final String firstText;
  final String secondText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            secondText,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
