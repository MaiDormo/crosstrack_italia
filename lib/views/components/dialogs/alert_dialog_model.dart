import 'package:flutter/material.dart';

//model for a reausable dialog
@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;
  final Map<String, T> buttons;

  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}

//extend the model with a presentation layer
extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) => showDialog<T>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: buttons.entries
              .map(
                (entry) => TextButton(
                  onPressed: () => Navigator.of(context).pop(entry.value),
                  child: Text(entry.key),
                ),
              )
              .toList(),
        ),
      );
}
