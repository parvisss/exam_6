import 'package:exam_6/data/models/expense.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DaromatHelper {
  static final DaromatHelper _instance = DaromatHelper._internal();
  factory DaromatHelper() => _instance;

  static Database? _database;

  DaromatHelper._internal();

  //! Create Table
  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'Daromat.db');
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE Daromat (
          id TEXT PRIMARY KEY,
          category TEXT,
          summ TEXT,
          date TEXT,
          comment TEXT
        )
      '''); // Removed trailing comma
    });
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  //! Insert Expense into SQL
  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert(
      'Daromat',
      expense.toMap(), // Call toMap() method
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //! Get all Daromat from SQL
  Future<List<Expense>> fetchDaromat() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('Daromat');
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        category: maps[i]['category'],
        summ: maps[i]['summ'],
        date: maps[i]['date'],
        comment: maps[i]['comment'],
      );
    });
  }

  //! Update Expense in SQL
  Future<int> updateExpense(Expense expense) async {
    final db = await database;
    return await db.update(
      'Daromat',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //! Delete Expense from SQL
  Future<int> deleteExpense(String id) async {
    final db = await database;
    return await db.delete(
      'Daromat',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
