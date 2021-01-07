import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todolist_app/modeles/tache.dart';
import 'package:todolist_app/modeles/todo.dart';
import 'package:todolist_app/screens/pageDesTaches.dart';
import 'package:todolist_app/widget.dart';
import 'package:todolist_app/bdd_gestion.dart';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class Accueil extends StatefulWidget {
  @override
  Accueil_State createState() => Accueil_State();
}

class Accueil_State extends State<Accueil> {
  BDDGestion db = BDDGestion();

  @override
  void initState() {
    super.initState();
    //quand on recup le state, on lance cette méthode qui contient le stream de ce qu'on recup avant.
    _configureSelectNotificationSubject();
    _createAllNotificationsFromTodos();
  }

  //afficher la fenetre de la liste de taches ou se trouvait le todo contenu dans la notif
  void _configureSelectNotificationSubject() {
    //lecture du stream
    selectNotificationSubject.stream.listen((String payload) async {
      List<Tache> taches = await db.getTaches();
      for (int i = 0; i < taches.length; i++) {
        if (int.parse(payload) == taches[i].id) {
          Tache t = taches[i];
          await Navigator.push(context, MaterialPageRoute<void>(
              builder: (context) => pageDesTaches(tache: t,)));
        }
      }
    });
  }

  //creer toutes les notifs.. les notifs restent si l'app est en tache de fond...
  //ce n'est pas des notifs push.. quand on ferme l'appli, elles disparaissent.
  void _createAllNotificationsFromTodos() async {
    //Init NotificationsDetails for android Platform
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "0", //id demandé
        "taches", // nom du chanel de notif
        "", //description du channel
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        showWhen: true); // quel moment a été déclenché la notif

    //contient les settings pour android
    //mcOs et iOS sont pas pris en compte car il faudrait tout gérer différement
    const NotificationDetails platformChannelsSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    List<Tache> taches = await db.getTaches();
    for (int i = 0; i < taches.length; i++) {
      List<Todo> todosTache = await db.getTodos(taches[i].id);
      for (int j = 0; j < todosTache.length; j++) {
        //print(todosTache[j].echeance);
        if (todosTache[j].echeance != null) {
          try {
            await localNotifications.zonedSchedule(
                todosTache[j].id,
                "La tâche " + todosTache[j].titre + " arrive à écheance",
                "Dans 10 minutes, cette tâche aura passer son écheance",
                tz.TZDateTime.parse(tz.local, todosTache[j].echeance).subtract(
                    Duration(minutes: 10)),
                platformChannelsSpecifics,
                uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
                    .absoluteTime,
                androidAllowWhileIdle: true,
                payload: taches[i].id.toString());
          } catch (ex) {
            //debugPrint("ERROR");
          }
        }
      }
    }

    //List<PendingNotificationRequest> pendingNotifications = await localNotifications.pendingNotificationRequests();
    //pendingNotifications.forEach((element) { print(element.id.toString() + " / " + element.payload); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            color: Color(0xFF171717),
            //Stack - superposition
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //placement du bouton (+)
                      margin: EdgeInsets.only(
                        top: 32,
                        //avant à 32 mais renderFlex overflowed
                        bottom: 32,
                      ),
                      child: Image(image: AssetImage('assets/images/logo.png')),
                    ),
                    Expanded(
                      //signifie qu'on peut naviger dans nos listes
                      child: FutureBuilder(
                        initialData: [],
                        future: db.getTaches(),
                        builder: (context, snapshot) {
                          return ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => pageDesTaches(
                                          tache: snapshot.data[index],
                                        ),
                                      ),
                                    ).then((value) {
                                      setState(
                                        () {},
                                      );
                                    });
                                  },
                                  child: TacheWidget(
                                    titre: snapshot.data[index].titre,
                                    desc: snapshot.data[index].description,
                                    couleurFond: snapshot.data[index].couleurFond,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                //Au lieu d'un floatingbutton
                Positioned(
                  bottom: 24,
                  right: 0,
                  child: GestureDetector(
                    //ajout d'une action sur le bouton (+)
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pageDesTaches(
                                  tache: null,
                                )),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              //Dégradé
                              colors: [Color(0xFF148BCC), Color(0xFF86829D)],
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, 1.0)),
                          //color: Color(0xFF148BCC),
                          borderRadius: BorderRadius.circular(20)),
                      child: Image(
                        //bouton flottant
                        image: AssetImage('assets/images/ajouter.png'),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
