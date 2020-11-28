import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_app/Tache.dart';

class BDDGestion{

Future<Database> bdd() async{
  return openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
    onCreate: (db, version)async {
      // Run the CREATE TABLE statement on the database.
      await db.execute("CREATE TABLE taches(id INTEGER PRIMARY KEY, titre TEXT, description TEXT)");
      await db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, titre TEXT, estFait INTEGER)");

      return db;
    },
      version: 1,
  );
}

Future<void> insertTache(Tache tache) async{
  Database db = await bdd();
  await db.insert('taches', tache.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}
Future <List<Tache>> getTache() async{
  Database db = await bdd();
  List<Map<String, dynamic>> tachesMap = await db.query('taches');
  return List.generate(tachesMap.length, (index){
    return Tache(id:tachesMap[index]['id'],titre:tachesMap[index]['titre'],description: tachesMap[index]['description'] );
  });
}
}