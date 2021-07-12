import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/common/restart_widget.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/repository/local_db_repository.dart';
import 'package:record_game_app/screens/home_screens/home_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up_login_select_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const RestartWidget(
      child: ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.purpleAccent,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            shape: const StadiumBorder(),
            elevation: 10,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            textStyle: const TextStyle(
              color: Colors.purple,
              fontStyle: FontStyle.italic,
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.purple),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
          ),
        ),
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
        backgroundColor: Colors.grey[200],
      ),
      home: AnimatedSplashScreen(
        splash: 'images/icon.png',
        backgroundColor: Colors.white,
        splashIconSize: 192,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: FutureBuilder(
          future: LocalDbRepository.instance.getIsDoneSignIn(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(body: LoadingScreen());
            } else if (snapshot.data == false) {
              return const SignUpLoginSelectScreen();
            } else {
              return HomeScreen();
            }
          },
        ),
      ),
    );
  }
}
