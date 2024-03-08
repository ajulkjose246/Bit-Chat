import 'package:bitchat/register/screenIntro.dart';
import 'package:bitchat/register/screenSignin.dart';
import 'package:bitchat/register/screenSignup.dart';
import 'package:bitchat/register/userAuth.dart';
import 'package:bitchat/themes/light_mode.dart';
import 'package:bitchat/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvide(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvide>(context).themeData,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => screenIntro(),
        'signIn': (context) => screenSignin(),
        'signUp': (context) => screenSignup(),
        'auth': (context) => userAuth(),
      },
      initialRoute: 'auth',
    );
  }
}
