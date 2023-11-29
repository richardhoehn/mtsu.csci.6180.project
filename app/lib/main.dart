import 'package:app/screens/home.dart';
import 'package:app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Setup Main - Login
final loginProvider = StateProvider<bool>((ref) => false);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isLoggedIn = ref.watch(loginProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MTSU Valet Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.bebasNeue(
            fontSize: 50,
          ),
          bodyMedium: GoogleFonts.bebasNeue(),
          displaySmall: GoogleFonts.bebasNeue(),
        ),
      ),
      home: isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
