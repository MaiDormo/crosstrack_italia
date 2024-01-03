import 'package:crosstrack_italia/common/shared_preferences.dart';
import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/splash_screen.dart';
import 'package:crosstrack_italia/views/tabs/home_page_view.dart';
import 'package:crosstrack_italia/views/components/loading/loading_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> initializeTileCache() async {
  await FlutterMapTileCaching.initialise();
  await FMTC.instance('mapStore').manage.createAsync();
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Activate Firebase App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
}

Future<void> main() async {
  // Display splash screen
  runApp(const SplashScreen());

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initializeFirebase();
    await initializeTileCache();
  } catch (e) {
    // Handle initialization errors
    print('Error initializing app: $e');
    // You may want to show an error screen or retry the initialization
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  runApp(
    // Maintain state of the App
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 876.6),
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: (fontSize, instance) => fontSize * instance.scaleWidth,
      builder: (_, child) => MaterialApp(
        title: 'Cross Track Italia',
        theme: ThemeData(
          scaffoldBackgroundColor:
              Color.fromRGBO(211, 211, 211, 0.9), // light gray
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
        home: Consumer(
          builder: (context, ref, child) {
            //take care of displaying the loading screen
            //in all possible instaces in all possible widgets
            //it does only need to listen to the isLoadingProvider,
            //which itself listen to the AuthStateProvider to get the
            //'loading' state
            ref.listen<bool>(
              isLoadingProvider,
              (_, isLoading) {
                if (isLoading) {
                  LoadingScreen.instance().show(
                    context: context,
                  );
                } else {
                  LoadingScreen.instance().hide();
                }
              },
            );

            //first screen
            return const HomePageView();
          },
        ),
      ),
    );
  }
}
