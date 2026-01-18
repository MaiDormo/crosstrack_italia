import 'package:crosstrack_italia/common/shared_preferences.dart';
import 'package:crosstrack_italia/splash_screen.dart';
import 'package:crosstrack_italia/views/tabs/home_page_view.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

// Conditional import for tile caching (not supported on web)
import 'tile_cache_stub.dart'
    if (dart.library.io) 'tile_cache_mobile.dart' as tile_cache;

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
          scaffoldBackgroundColor:
              const Color.fromRGBO(120, 135, 155, 0.9),
          colorScheme: ColorScheme.fromSeed(
            seedColor:
                const Color.fromRGBO(50, 65, 85, 0.9), // dark, desaturated blue
            brightness: Brightness.light,
            primary: const Color.fromRGBO(
                50, 65, 85, 0.9), // dark, desaturated green
            secondary: const Color.fromRGBO(
                50, 65, 85, 0.96), // dark, desaturated orange
            tertiary: const Color.fromRGBO(211, 211, 211, 0.9), // light gray
          ),
          useMaterial3: true,
          hintColor:
              const Color.fromRGBO(85, 65, 50, 0.9), // dark, desaturated orange
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                  fontSizeFactor: 1.0.sp,
                ),
          ),
        ),
        home: const HomePageView(),
      ),
    );
  }
}
