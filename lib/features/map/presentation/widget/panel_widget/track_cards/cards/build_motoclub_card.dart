import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget buildMotoclubCard(
  Track selectedTrack,
  BuildContext context,
) {
  final colorScheme = Theme.of(context).colorScheme;
  
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.groups_rounded,
                  size: 18.r,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Motoclub',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            selectedTrack.motoclub,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          _buildWebsiteButton(selectedTrack, context),
        ],
      ),
    ),
  );
}

Widget _buildWebsiteButton(Track selectedTrack, BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final hasWebsite = selectedTrack.website.isNotEmpty;
  
  return Material(
    color: hasWebsite 
        ? colorScheme.primary 
        : colorScheme.onSurface.withValues(alpha: 0.1),
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: hasWebsite 
          ? () => _launchWebsite(selectedTrack.website, context)
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.language_rounded,
              size: 18.r,
              color: hasWebsite 
                  ? Colors.white 
                  : colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            SizedBox(width: 8.w),
            Text(
              hasWebsite ? 'Visita sito' : 'Nessun sito',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: hasWebsite 
                    ? Colors.white 
                    : colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> _launchWebsite(String website, BuildContext context) async {
  try {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Apertura sito web...'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    bool launched = await launchUrlString(website);

    if (!context.mounted) return;
    
    Future.delayed(const Duration(seconds: 1), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });

    if (!launched) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Sito non apribile, riprova più tardi'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Errore nell\'apertura del sito web'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
