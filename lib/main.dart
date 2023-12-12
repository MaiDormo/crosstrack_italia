import 'package:crosstrack_italia/common/shared_preferences.dart';
import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/splash_screen.dart';
import 'package:crosstrack_italia/views/tabs/home_page_view.dart';
import 'package:crosstrack_italia/views/components/loading/loading_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Display splash screen
  runApp(const SplashScreen());

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Activate Firebase App Check
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );

    // Initialize tile cache
    await FlutterMapTileCaching.initialise();
    await FMTC.instance('mapStore').manage.createAsync();
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
    return MaterialApp(
      title: 'Cross Track Italia',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[50],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
          primary: Colors.blue[800],
          secondary: Colors.blue[200],
          tertiary: Colors.white,
        ),
        useMaterial3: true,
        hintColor: Colors.amber,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.grey[900],
                displayColor: Colors.grey[900],
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
    );
  }
}

//Difference between watch and listen in providers:
// watch: is asynchronous that means that it is mostly used to rebuild the
//        closest widget in the hierarchy when something happens
// listen:
