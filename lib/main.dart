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
    if (dart.library.io) 'tile_cache_mobile.dart'
    as tile_cache;
import 'views/tabs/home_page_view.dart';

/// Design size for the app (typical mobile phone dimensions)
const Size kDesignSize = Size(411.4, 876.6);

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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Skip App Check on web in debug mode - it requires reCAPTCHA setup
  if (!kIsWeb) {
    await FirebaseAppCheck.instance.activate(
      // ignore: deprecated_member_use
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
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
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

    // On web with landscape/wide screens, show the app in a phone frame
    if (kIsWeb) {
      return _WebPhoneFrameApp();
    }

    // Mobile: normal ScreenUtil setup
    return ScreenUtilInit(
      designSize: kDesignSize,
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) => MaterialApp(
        title: 'Cross Track Italia',
        theme: _buildTheme(),
        home: const HomePageView(),
      ),
    );
  }
}

/// Web-specific wrapper that shows the app in a phone frame on landscape screens.
///
/// This widget handles the MediaQuery override BEFORE ScreenUtil is initialized,
/// ensuring that ScreenUtil sees the correct (phone) dimensions.
class _WebPhoneFrameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cross Track Italia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.primaryDark,
      ),
      home: const _WebLayoutSwitcher(),
    );
  }
}

/// Switches between phone frame layout (landscape) and normal layout (portrait)
class _WebLayoutSwitcher extends StatelessWidget {
  const _WebLayoutSwitcher();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isLandscape = screenWidth > screenHeight;
        final aspectRatio = screenWidth / screenHeight;

        // For landscape or wide aspect ratios (> 1.2), show phone mockup
        if (isLandscape || aspectRatio > 1.2) {
          return _PhoneFrameLayout(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          );
        }

        // Portrait web: use normal layout with ScreenUtil
        return _buildNormalApp(context);
      },
    );
  }

  Widget _buildNormalApp(BuildContext context) {
    return ScreenUtilInit(
      designSize: kDesignSize,
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) =>
          Theme(data: _buildTheme(), child: const HomePageView()),
    );
  }
}

/// Phone frame layout for landscape/desktop web viewing
/// Layout: App info on left, phone mockup on right
class _PhoneFrameLayout extends StatelessWidget {
  const _PhoneFrameLayout({
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    // Calculate phone size - use up to 85% of height
    final maxPhoneHeight = screenHeight * 0.85;
    final maxPhoneWidth = screenWidth * 0.45; // Leave room for info section

    final scaleX = maxPhoneWidth / kDesignSize.width;
    final scaleY = maxPhoneHeight / kDesignSize.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    final phoneWidth = kDesignSize.width * scale;
    final phoneHeight = kDesignSize.height * scale;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
          colors: [Color(0xFF0A1628), Color(0xFF0F2744), Color(0xFF0A1628)],
        ),
      ),
      child: Stack(
        children: [
          // Subtle pattern overlay
          Positioned.fill(child: CustomPaint(painter: _GridPatternPainter())),
          // Decorative gradient orbs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Main content: Info left, Phone right
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.05,
            ),
            child: Row(
              children: [
                // Left side: App info
                Expanded(
                  flex: 5,
                  child: Material(
                    color: Colors.transparent,
                    child: _AppInfoSection(screenHeight: screenHeight),
                  ),
                ),
                const SizedBox(width: 40),
                // Right side: Phone mockup
                _PhoneDevice(phoneWidth: phoneWidth, phoneHeight: phoneHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Left section with app information
class _AppInfoSection extends StatelessWidget {
  const _AppInfoSection({required this.screenHeight});

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App logo/icon placeholder
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.motorcycle,
            color: AppColors.accent,
            size: 32,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        // App name
        Text(
          'Cross Track',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
        Text(
          'Italia',
          style: GoogleFonts.poppins(
            color: AppColors.accent,
            fontSize: 42,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        // Tagline
        Text(
          'Scopri i migliori tracciati motocross\ndel Nord Italia',
          style: GoogleFonts.poppins(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        // Feature highlights
        const _FeatureItem(
          icon: Icons.map_outlined,
          text: 'Mappa interattiva dei circuiti',
        ),
        SizedBox(height: screenHeight * 0.015),
        const _FeatureItem(
          icon: Icons.compare_arrows,
          text: 'Confronta le piste',
        ),
        SizedBox(height: screenHeight * 0.015),
        const _FeatureItem(
          icon: Icons.star_outline,
          text: 'Salva i tuoi preferiti',
        ),
        SizedBox(height: screenHeight * 0.015),
        const _FeatureItem(
          icon: Icons.info_outline,
          text: 'Dettagli completi su ogni tracciato',
        ),
        SizedBox(height: screenHeight * 0.05),
        // Download hint
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone_android,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Disponibile su Android',
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Feature list item
class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.accent, size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// Phone device mockup widget
class _PhoneDevice extends StatelessWidget {
  const _PhoneDevice({required this.phoneWidth, required this.phoneHeight});

  final double phoneWidth;
  final double phoneHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: phoneWidth + 16,
      height: phoneHeight + 16,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.05),
            blurRadius: 80,
            spreadRadius: -20,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: _ScaledPhoneContent(
          phoneWidth: phoneWidth,
          phoneHeight: phoneHeight,
        ),
      ),
    );
  }
}

/// The actual phone content, rendered at design size and scaled down
class _ScaledPhoneContent extends StatefulWidget {
  const _ScaledPhoneContent({
    required this.phoneWidth,
    required this.phoneHeight,
  });

  final double phoneWidth;
  final double phoneHeight;

  @override
  State<_ScaledPhoneContent> createState() => _ScaledPhoneContentState();
}

class _ScaledPhoneContentState extends State<_ScaledPhoneContent> {
  @override
  void initState() {
    super.initState();
    _configureScreenUtil();
  }

  void _configureScreenUtil() {
    const fakeMediaQuery = MediaQueryData(
      size: kDesignSize,
      devicePixelRatio: 1.0,
      textScaler: TextScaler.noScaling,
      padding: EdgeInsets.zero,
      viewPadding: EdgeInsets.zero,
      viewInsets: EdgeInsets.zero,
    );

    ScreenUtil.configure(
      data: fakeMediaQuery,
      designSize: kDesignSize,
      splitScreenMode: false,
      minTextAdapt: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Re-configure on every build to ensure ScreenUtil stays configured
    _configureScreenUtil();

    // Render at exact design size, then scale with FittedBox
    return SizedBox(
      width: widget.phoneWidth,
      height: widget.phoneHeight,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: kDesignSize.width,
          height: kDesignSize.height,
          child: MediaQuery(
            data: const MediaQueryData(
              size: kDesignSize,
              devicePixelRatio: 1.0,
              textScaler: TextScaler.noScaling,
              padding: EdgeInsets.zero,
              viewPadding: EdgeInsets.zero,
              viewInsets: EdgeInsets.zero,
            ),
            // Use a MaterialApp to provide proper Navigator for the phone content
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: _buildTheme(),
              home: const HomePageView(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for subtle grid pattern background
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.02)
      ..strokeWidth = 1;

    const spacing = 40.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

ThemeData _buildTheme() {
  return ThemeData(
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.textMuted.withValues(alpha: 0.2),
      thickness: 1,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primaryDark,
      contentTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
