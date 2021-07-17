import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/restart_widget.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
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
    final _appUserModel = useProvider(appUserStateProvider.notifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '試合記録アプリ',
      locale: const Locale('ja', 'JP'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ja', 'JP'),
      ],
      home: AnimatedSplashScreen(
        splash: 'images/icon.png',
        backgroundColor: Colors.white,
        splashIconSize: 192,
        splashTransition: SplashTransition.rotationTransition,
        nextScreen: FutureBuilder(
          future: _appUserModel.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: LoadingScreen(context));
            } else if (snapshot.data == null) {
              return const SignUpLoginSelectScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.purpleAccent,
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              shape: const StadiumBorder(),
              elevation: 10),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            textStyle: const TextStyle(color: Colors.purple),
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
        ),
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
        backgroundColor: Colors.grey[200],
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        appBarTheme: const AppBarTheme(centerTitle: false),
      ),
    );
  }
}
