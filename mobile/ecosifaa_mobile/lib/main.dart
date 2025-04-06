import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/bitki_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => BitkiProvider()),
      ],
      child: MaterialApp(
        title: 'EcoSifaa',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('tr', 'TR'), // Türkçe
          Locale('en', 'US'), // İngilizce
        ],
        locale: const Locale('tr', 'TR'),
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        home: const HomeScreen(),
        // Burada bir kimlik doğrulama kontrolü yapılabilir:
        // home: auth.isAuth ? HomeScreen() : LoginScreen(),
        routes: {
          '/home': (ctx) => const HomeScreen(),
        },
      ),
    );
  }
} 