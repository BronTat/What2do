import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todolist_app/screens/accueil.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin localNotifications;
final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

void main() async {
  //Obligatoire si initialisation dans "main" - Plugin flutter_local_notifications
  WidgetsFlutterBinding.ensureInitialized();

  //Configure la TimeZone (obligatoire pour les notifications prévus
  tz.initializeTimeZones();

  //Initialisation du plugin pour les notifications locales
  localNotifications = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('todo_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
  );
  await localNotifications.initialize(initializationSettings, onSelectNotification: selectNotification);
  runApp(MyApp());
}

//Fonction lancé si la notification est cliquer par l'utilisateur
Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  selectNotificationSubject.add(payload);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
        Theme.of(context).textTheme,
      )),
      home: Accueil(

      ),
    );
  }
}
