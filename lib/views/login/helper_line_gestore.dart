import 'package:flutter/material.dart';

class HelperLineGestore extends StatelessWidget {
  const HelperLineGestore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: <TextSpan>[
              const TextSpan(
                text:
                    'Nel caso sei un gestore di un tracciato, dopo l\'accesso puoi cominciare la procedura all\'interno delle ',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              TextSpan(
                text: 'Impostazioni',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
