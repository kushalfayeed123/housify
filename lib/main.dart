import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housify/router.dart';
import 'package:housify/service_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupProvider();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make status bar transparent
      statusBarIconBrightness:
          Brightness.light, // Set icons to light (for dark backgrounds)
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Housify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.openSans(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.05,
              height: 0.8),
          bodyLarge: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.05,
              height: 0.8),
          bodyMedium: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.05,
              height: 0.7),
          bodySmall: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.05,
              height: 0.7),
        ),
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
