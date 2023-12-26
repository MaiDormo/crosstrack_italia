import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              FlutterLogo(
                size: 100.0.w,
              ),
              20.verticalSpace,
              Text(
                'My Awesome App',
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
              20.verticalSpace,
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
