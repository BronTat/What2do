import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_app/Tache.dart';

class BDDGestion{

Future<Database> bdd() async{
  return openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE taches(id INTEGER PRIMARY KEY, titre TEXT, description TEXT)",
      );
    },
      version: 1,
  );
}

Future<void> insertTache(Tache tache) async{
  Database db = await bdd();
  await db.insert('taches', tache.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

}