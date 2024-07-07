// ignore_for_file: non_constant_identifier_names

import 'package:sqflite/sqflite.dart' as sql;

class SQLoperation {
// Data base creation

  static Future<sql.Database> createDB() async {
    return sql.openDatabase('mycontacts.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

// table creation
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        cname TEXT,
        cnumber TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  // to add name and phone number to contacts table
  static Future<int> create_contact(String name, String phoneNum) async {
    final db = await SQLoperation.createDB(); //open database

    final data = {'cname': name, 'cnumber': phoneNum};

    // insert to a particular table with values as map
    final id = await db.insert('contacts', data);
    
    return id;
  }

// fetch and read all the contacts from the database
  static Future<List<Map<String, dynamic>>> readContacts() async {
    final db = await SQLoperation.createDB(); //open database
  // read all the values from database
    return db.query('contacts', orderBy: 'id');
  }
}
