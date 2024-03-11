import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bitchat/register/screenIntro.dart';
import 'package:bitchat/register/screenSignin.dart';
import 'package:bitchat/register/screenSignup.dart';
import 'package:bitchat/register/screenUserData.dart';
import 'package:bitchat/register/userAuth.dart';
import 'package:bitchat/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "bit_chat_notification_channel",
          channelName: "Basic Notifications",
          channelDescription: "notification channel description",
        )
      ],
      debug: true);
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
        '/': (context) => const screenIntro(),
        'signIn': (context) => const screenSignin(),
        'signUp': (context) => const screenSignup(),
        'userData': (context) => const screenUserData(),
        'auth': (context) => const userAuth(),
      },
      initialRoute: 'auth',
    );
  }
}
