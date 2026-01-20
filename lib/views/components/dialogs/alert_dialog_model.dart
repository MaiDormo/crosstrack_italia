import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//model for a reausable dialog
@immutable
class AlertDialogModel<T> {

  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
  final String title;
  final String message;
  final Map<String, T> buttons;
}

//extend the model with a presentation layer
extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: colorScheme.onSurface,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        actions: buttons.entries.map((entry) {
          // Style destructive actions (like "Delete", "Log out") differently
          final isDestructive = entry.key.toLowerCase().contains('elimina') ||
              entry.key.toLowerCase().contains('esci') ||
              entry.key.toLowerCase().contains('cancella') ||
              entry.key.toLowerCase().contains('delete') ||
              entry.key.toLowerCase().contains('log out');
          final isCancel = entry.key.toLowerCase().contains('annulla') ||
              entry.key.toLowerCase().contains('cancel');

          if (isCancel) {
            return TextButton(
              onPressed: () => Navigator.of(context).pop(entry.value),
              child: Text(
                entry.key,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            );
          }

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDestructive 
                  ? const Color(0xFFEF4444)
                  : colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            onPressed: () => Navigator.of(context).pop(entry.value),
            child: Text(
              entry.key,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
        actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      ),
    );
  }
}
