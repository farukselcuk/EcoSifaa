import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ecosifaa_mobile/screens/home_screen.dart';
import 'package:ecosifaa_mobile/providers/bitki_provider.dart';
import 'package:ecosifaa_mobile/providers/rahatsizlik_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BitkiProvider()),
        ChangeNotifierProvider(create: (_) => RahatsizlikProvider()),
      ],
      child: MaterialApp(
        title: 'EcoSifaa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
} 