import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/shared_preferences.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';
// Conditional import for tile caching (not supported on web)
import 'tile_cache_stub.dart'
    if (dart.library.io) 'tile_cache_mobile.dart' as tile_cache;
import 'views/tabs/home_page_view.dart';

/// App color palette - Professional blue-oriented style
class AppColors {
  AppColors._();

  // Primary - Deep professional blue
  static const primary = Color(0xFF1E3A5F);
  static const primaryLight = Color(0xFF2E5077);
  static const primaryDark = Color(0xFF0F2744);

  // Secondary - Complementary steel blue
  static const secondary = Color(0xFF3D5A80);
  static const secondaryLight = Color(0xFF5C7A99);

  // Accent - Subtle teal for highlights
  static const accent = Color(0xFF4A90A4);
  static const accentLight = Color(0xFF6BB3C9);

  // Background
  static const background = Color(0xFFF5F7FA);
  static const surface = Colors.white;
  static const surfaceVariant = Color(0xFFEEF2F6);

  // Text
  static const textPrimary = Color(0xFF1A2B3C);
  static const textSecondary = Color(0xFF5A6978);
  static const textMuted = Color(0xFF8A96A3);

  // Semantic
  static const success = Color(0xFF2E7D5A);
  static const warning = Color(0xFFD4A534);
  static const error = Color(0xFFC54B4B);
  static const info = Color(0xFF4A90A4);
}

/// Initializes Firebase and App Check.
///
/// Uses debug provider in debug mode for easier development,
/// and Play Integrity/reCAPTCHA in release builds for production security.
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Skip App Check on web in debug mode - it requires reCAPTCHA setup
  if (!kIsWeb) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: kDebugMode 
          ? AndroidProvider.debug 
          : AndroidProvider.playIntegrity,
    );
  }
}

Future<void> main() async {
  runApp(const SplashScreen());

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initializeFirebase();
  } catch (e, stack) {
    debugPrint('Firebase initialization error: $e');
    debugPrint('Stack trace: $stack');
    // Continue without Firebase if it fails in debug mode
    if (!kDebugMode) return;
  }

  try {
    await tile_cache.initializeTileCache();
  } catch (e, stack) {
    debugPrint('Tile cache initialization error: $e');
    debugPrint('Stack trace: $stack');
    // Continue without tile cache - it's optional
  }

  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Allow all orientations on web/desktop, portrait only on mobile
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    return ScreenUtilInit(
      designSize: const Size(411.4, 876.6),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use shorter dimension as width for landscape
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp(
        title: 'Cross Track Italia',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.light,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            tertiary: AppColors.accent,
            surface: AppColors.surface,
            surfaceContainerHighest: AppColors.surfaceVariant,
            onSurface: AppColors.textPrimary,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            error: AppColors.error,
          ),
          useMaterial3: true,
          cardTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: AppColors.surface,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintStyle: GoogleFonts.poppins(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w400,
            ),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: AppColors.textPrimary,
                  displayColor: AppColors.textPrimary,
                ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
          ),
          chipTheme: ChipThemeData(
            backgroundColor: AppColors.surfaceVariant,
            selectedColor: AppColors.accent.withValues(alpha: 0.2),
            labelStyle: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          dividerTheme: DividerThemeData(
            color: AppColors.textMuted.withValues(alpha: 0.2),
            thickness: 1,
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: AppColors.primaryDark,
            contentTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        ),
        home: const HomePageView(),
      ),
    );
  }
}
