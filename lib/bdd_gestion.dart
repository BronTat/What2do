import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';
import 'modeles/tache.dart';
import 'modeles/todo.dart';
import 'package:timezone/timezone.dart' as tz;

class BDDGestion {
  Future<Database> bdd() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
            "CREATE TABLE taches(id INTEGER PRIMARY KEY, titre TEXT, description TEXT, couleurFond INTEGER)");
        await db.execute(
            "CREATE TABLE todo(id INTEGER PRIMARY KEY, tacheId INTEGER, titre TEXT, estFait INTEGER, echeance TEXT)");

        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTache(Tache tache) async {
    int tacheId = 0;
    Database db = await bdd();
    await db
        .insert('taches', tache.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      tacheId = value;
    });

    return tacheId;
  }

  Future<void> updateTitreTache(int id, String titre) async {
    Database db = await bdd();
    await db.rawUpdate("UPDATE taches SET titre = '$titre' WHERE id = '$id'");
  }

  Future<void> updateDescriptionTache(int id, String description) async {
    Database db = await bdd();
    await db.rawUpdate(
        "UPDATE taches SET description = '$description' WHERE id = '$id'");
  }

  Future<void> insertTodo(Todo todo) async {
    Database db = await bdd();
    await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Tache>> getTaches() async {
    Database db = await bdd();
    List<Map<String, dynamic>> tachesMap = await db.query('taches');
    return List.generate(tachesMap.length, (index) {
      return Tache(
          id: tachesMap[index]['id'],
          titre: tachesMap[index]['titre'],
          description: tachesMap[index]['description'],
          couleurFond: tachesMap[index]['couleurFond']);
    });
  }

  Future<List<Todo>> getTodos(int tacheId) async {
    Database db = await bdd();
    List<Map<String, dynamic>> todoMap =
        await db.rawQuery("SELECT * FROM todo WHERE tacheId = $tacheId");
    return List.generate(todoMap.length, (index) {
      return Todo(
          id: todoMap[index]['id'],
          titre: todoMap[index]['titre'],
          tacheId: todoMap[index]['tacheId'],
          estFait: todoMap[index]['estFait'],
          echeance: todoMap[index]['echeance']);
    });
  }

  Future<void> updateTodoEstFaite(int id, int estFait) async {
    Database db = await bdd();
    await db.rawUpdate("UPDATE todo SET estFait = '$estFait' WHERE id = '$id'");
  }

  Future<void> updateTodoDateEcheance(int id, String echeance) async {
    Database db = await bdd();
    await db
        .rawUpdate("UPDATE todo SET echeance = '$echeance' WHERE id = '$id'");
    _createAllNotificationsFromTodos();
  }

  Future<void> updateTachesCouleurFond(int id, int couleurFond) async {
    Database db = await bdd();
    await db.rawUpdate(
        "UPDATE taches SET couleurFond = '$couleurFond' WHERE id = '$id'");
  }

  Future<void> deleteTache(int id) async {
    Database db = await bdd();
    await db.rawDelete("DELETE FROM taches WHERE id = '$id'");
    await db.rawDelete("DELETE FROM todo WHERE tacheId = '$id'");
  }


}

//creer toutes les notifs.. les notifs restent si l'app est en tache de fond...
//ce n'est pas des notifs push.. quand on ferme l'appli, elles disparaissent.
void _createAllNotificationsFromTodos() async {
  BDDGestion db =  BDDGestion();
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
          await localNotifications.zonedSchedule( //creer la notif par rapport a une heure donnée
              todosTache[j].id,
              "La tâche " + todosTache[j].titre + " arrive à écheance",
              "Dans 10 minutes, cette tâche aura passé son écheance",
              tz.TZDateTime.parse(tz.local, todosTache[j].echeance).subtract(
                  Duration(minutes: 10)),
              platformChannelsSpecifics,
              uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
                  .absoluteTime,
              androidAllowWhileIdle: true, //meme si le telephone fait rien, la notif peut se lancer
              payload: taches[i].id.toString());// info pour le selectNotification dans main.dart
        } catch (ex) {
          //debugPrint("ERROR");
        }
      }
    }
  }
}
