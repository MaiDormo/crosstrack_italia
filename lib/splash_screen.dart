import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import AppColors for consistency
const _primaryColor = Color(0xFF1E3A5F);
const _secondaryColor = Color(0xFF3D5A80);

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive sizing based on screen dimensions
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final isSmallScreen = screenWidth < 400;
              
              // Logo size scales with screen, max 400x300
              final logoWidth = (screenWidth * 0.8).clamp(200.0, 400.0);
              final logoHeight = logoWidth * 0.75; // 4:3 aspect ratio
              
              // Font size scales with screen
              final titleFontSize = isSmallScreen ? 18.0 : 24.0;
              final spacing = screenHeight * 0.02;

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: _primaryColor.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        width: logoWidth,
                        height: logoHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/logo/logo_4:3.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: spacing),
                      Text(
                        'Cross Track Italia',
                        style: GoogleFonts.poppins(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: _primaryColor,
                        ),
                      ),
                      SizedBox(height: spacing * 0.5),
                      Text(
                        'Caricamento in corso...',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _secondaryColor.withValues(alpha: 0.7),
                        ),
                      ),
                      SizedBox(height: spacing),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          color: _secondaryColor,
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
