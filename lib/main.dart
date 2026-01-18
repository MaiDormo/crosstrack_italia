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
/// and Play Integrity in release builds for production security.
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    // Use debug provider in debug mode, Play Integrity in release
    androidProvider: kDebugMode 
        ? AndroidProvider.debug 
        : AndroidProvider.playIntegrity,
  );
}

Future<void> main() async {
  runApp(const SplashScreen());

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initializeFirebase();
    await tile_cache.initializeTileCache();
  } catch (e) {
    debugPrint('Initialization error: $e');
    return;
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(411.4, 876.6),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        title: 'Cross Track Italia',
        theme: ThemeData(
          scaffoldBackgroundColor:
              // Color.fromRGBO(211, 211, 211, 0.9), // light gray
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
