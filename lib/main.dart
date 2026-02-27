import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'home_page.dart';

void main() {
  // Preserve splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Lock to portrait mode (Android + iOS)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const BalladeArtApp());

    // Remove splash after 3 seconds (same as iOS)
    Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });
  });
}

class BalladeArtApp extends StatelessWidget {
  const BalladeArtApp({super.key});

  static const Color bg = Color(0xFF222831);        // arka plan
  static const Color ink = Color(0xFFDFD0B8);       // krem/şampanya
  static const Color inkDim = Color(0x66DFD0B8);    // soluk çizgi

  @override
  Widget build(BuildContext context) {
    final baseText = GoogleFonts.cinzel(
      color: ink,
      letterSpacing: 2,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ballade Art',
      theme: ThemeData(
        scaffoldBackgroundColor: bg,
        sliderTheme: const SliderThemeData(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          trackHeight: 2,
        ),
        textTheme: TextTheme(
          bodyMedium: baseText.copyWith(fontSize: 14),
          titleLarge: baseText.copyWith(fontSize: 28, letterSpacing: 4),
          titleMedium: baseText.copyWith(fontSize: 18),
          labelMedium: baseText.copyWith(fontSize: 12, color: inkDim),
        ),
        iconTheme: const IconThemeData(color: ink),
        colorScheme: const ColorScheme.dark(primary: ink, surface: bg),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}