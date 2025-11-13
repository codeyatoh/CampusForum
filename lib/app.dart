import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contexts/dark_mode_context.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);

    // Load Poppins font
    final textTheme = TextTheme(
      displayLarge: GoogleFonts.poppins(fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: 0),
      displayMedium: GoogleFonts.poppins(fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: 0),
      displaySmall: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0),
      headlineLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0),
      headlineMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineSmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0),
      titleLarge: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      labelMedium: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
      labelSmall: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    );

    final lightTheme = AppTheme.lightTheme().copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
    );

    final darkTheme = AppTheme.darkTheme().copyWith(
      textTheme: textTheme.apply(
        bodyColor: AppTheme.darkText,
        displayColor: AppTheme.darkText,
      ),
      primaryTextTheme: textTheme.apply(
        bodyColor: AppTheme.darkText,
        displayColor: AppTheme.darkText,
      ),
    );

    return MaterialApp.router(
      title: 'CampusForum',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: darkModeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}

