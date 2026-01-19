import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelperLineGestore extends StatelessWidget {
  const HelperLineGestore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            children: <TextSpan>[
              const TextSpan(
                text:
                    'Nel caso sei un gestore di un tracciato, dopo l\'accesso puoi cominciare la procedura all\'interno delle ',
              ),
              TextSpan(
                text: 'Impostazioni',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
