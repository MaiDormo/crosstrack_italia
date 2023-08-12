import 'package:crosstrack_italia/states/providers/is_loading_provider.dart';
import 'package:crosstrack_italia/views/homepage/home_page_view.dart';
import 'package:crosstrack_italia/views/components/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    //Maintaining state of the App
    const ProviderScope(
      child: MyApp(),
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
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
          primary: Colors.orange[800],
          secondary: Colors.black,
          tertiary: Colors.white,
        ),
        useMaterial3: true,
        //indeed it does
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
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
