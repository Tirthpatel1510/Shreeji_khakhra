import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  MyApp({super.key});  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Shreeji Khakhra',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
          useMaterial3: true,

          colorScheme: const ColorScheme.light(
            primary: Color(0xFFF77F00), // Orange 
            onPrimary: Colors.white,
            secondary: Color(0xFF7B3F00), // Brown
            onSecondary: Colors.white,
            background: Color(0xFFFFF4E0), // Cream
            surface: Color(0xFFFFF8EC),
            tertiary: Color(0xFFFFD700),
          ),

          scaffoldBackgroundColor: Color(0xFFFFF4E0),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF77F00),
              foregroundColor: Colors.white,
            ),
          ),

          textTheme: const TextTheme(
            titleLarge: TextStyle(     

              color: Color(0xFF7B3F00),
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Color(0xFF4B2B00),
            ),
          ),
        ),

        home: SplashScreen(), // ❌ remove const
      ),
    );
  }
}