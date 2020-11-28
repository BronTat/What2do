import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'file:///C:/Users/nicolas.jeanmair/AndroidStudioProjects/ToDoListFlutter/lib/modeles/tache.dart';
import 'modeles/todo.dart';

class BDDGestion{

Future<Database> bdd() async{
  return openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
    onCreate: (db, version)async {
      // Run the CREATE TABLE statement on the database.
      await db.execute("CREATE TABLE taches(id INTEGER PRIMARY KEY, titre TEXT, description TEXT)");
      await db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, tacheId INTEGER, titre TEXT, estFait INTEGER)");

      return db;
    },
      version: 1,
  );
}

Future<void> insertTache(Tache tache) async{
  Database db = await bdd();
  await db.insert('taches', tache.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> insertTodo(Todo todo) async{
  Database db = await bdd();
  await db.insert('todo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}


Future <List<Tache>> getTaches() async{
  Database db = await bdd();
  List<Map<String, dynamic>> tachesMap = await db.query('taches');
  return List.generate(tachesMap.length, (index){
    return Tache(id:tachesMap[index]['id'],titre:tachesMap[index]['titre'],description: tachesMap[index]['description'] );
  });
}

Future <List<Todo>> getTodos(int tacheId) async{
  Database db = await bdd();
  List<Map<String, dynamic>> todoMap = await db.rawQuery("SELECT * FROM todo WHERE tacheId = $tacheId");
  return List.generate(todoMap.length, (index){
    return Todo(id:todoMap[index]['id'],titre:todoMap[index]['titre'],tacheId: todoMap[index]['tacheId'] ,estFait: todoMap[index]['estFait']);
  });
}
}