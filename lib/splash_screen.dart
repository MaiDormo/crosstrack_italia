import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Add MaterialApp and specify your app theme
      theme: ThemeData(
        // Specify your theme properties
        scaffoldBackgroundColor: Colors.white,
        // Add any other theme properties you need
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 400,
                height: 300,
                child: Image.asset(
                  'assets/images/logo/logo_4:3.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Cross Track Italia',
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
