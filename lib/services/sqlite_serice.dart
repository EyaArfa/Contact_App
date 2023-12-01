import 'package:callapp/Models/Conatct.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
   static const _tableName = 'contact';

  static  const _columnName = 'name';
  static  const _columnId = '_id';
   static const _columnLastName = 'lastname';
   static const _columnPhone = 'phone';
   static const _columnImage = 'image';
   static const _dbName = 'contactDB.db';
   static const _dbVersion = 1;




   Future<Database> initizateDb() async {
    WidgetsFlutterBinding.ensureInitialized();

    print('before initializing ');
    String directory = await getDatabasesPath();
    print(directory);
    String path = join(directory, 'contacts');
    var data= await openDatabase(
     path,
      version: _dbVersion,
      onCreate:  (db, version) async{
        await _onCreate(db, version);
      },
    );
    print(await data.query("sqlite_master"));
    return data;
  }

   Future _onCreate(database, version) async {
    await database.execute(
      '''CREATE TABLE IF NOT EXISTS $_tableName(
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_columnName varchar(10) not null,
        $_columnLastName varchar(10) not null,
        $_columnPhone varchar(30) not null,
        $_columnImage varchar(100) not null
        )''',
    );
  }

  Future<int> createContact(Contact contact) async {
    print(contact.toMap());
    final  db = await initizateDb();
    final id = await db.insert('contact', contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    return id;
  }



   Future<int> deleteContact(int id) async {
    final Database db = await initizateDb();
    return await db.delete('contact', where: '$_columnId=?', whereArgs: [id]);
  }

   Future<List<Contact>> getItems() async {
    final db = await initizateDb();
    final List<Map<String, Object?>> queryResult =
    await db.query('contact', orderBy: _columnName);
    return queryResult.map((e)  {print(Contact.fromMap(e).image);return Contact.fromMap(e);}).toList();
  }

   Future<int> updateContact(Contact contact) async {
     print('to be updated${contact.toMap()}');
    final Database db = await initizateDb();
    return await db.update('contact', contact.toMap(),
        where: '$_columnId=?', whereArgs: [contact.id]);
  }
}
