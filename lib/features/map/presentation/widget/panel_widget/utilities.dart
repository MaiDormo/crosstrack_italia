import 'package:flutter/material.dart';

Widget buildRow(List<Widget> children) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );

Widget buildCard(
  Widget child,
  BuildContext context,
) =>
    Card(
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );

Widget buildStyledText({
  required String text,
  required double fontSize,
  required FontWeight fontWeight,
  Color? color,
}) =>
    Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );

void showSnackBar(BuildContext context, bool value, String loadingMessage,
    String errorMessage) {
  final snackBar =
      SnackBar(content: Text(value ? loadingMessage : errorMessage));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
