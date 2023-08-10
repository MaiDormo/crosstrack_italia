import 'package:flutter/material.dart';

class RoundGestureDetector extends StatelessWidget {
  const RoundGestureDetector({
    super.key,
    required this.labelText,
    required this.onTap,
  });
  final String labelText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
