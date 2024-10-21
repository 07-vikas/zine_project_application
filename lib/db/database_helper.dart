import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/notification_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notifications.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the notifications table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        text TEXT
      )
    ''');
  }

  // Insert a notification into the database
  Future<int> insertNotification(NotificationModel notification) async {
    final db = await database;
    return await db.insert('notifications', notification.toMap());
  }

  // Retrieve all notifications from the database
  Future<List<NotificationModel>> getNotifications() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notifications');
    return List.generate(maps.length, (i) {
      return NotificationModel.fromMap(maps[i]);
    });
  }
}
