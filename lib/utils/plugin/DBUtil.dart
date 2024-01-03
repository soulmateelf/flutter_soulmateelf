import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// SQLite数据库工具类
class DBUtil {
  /// 单例对象
  static DBUtil? instance;
  static late Database database;

  /// 单例模式
  DBUtil._internal(){
    _initDatabase();
  }
  /// 初始化工具类
  static init(){
    instance ??= DBUtil._internal();
  }
  /// 初始化数据库对象
  /// 在 SQLite 中，数据库的创建通常是通过打开一个不存在的数据库文件时进行的，而不是通过显式的“创建数据库”语句进行的。
  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'soulmate.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabaseTable,
    );
  }
  /// 初始化数据库表
  /// 用户角色聊天信息表是动态的，需要在用户登录后，根据用户角色动态创建
  /// 这里只创建了同步信息表
  Future<void> _createDatabaseTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS syncRecord (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recordId TEXT,
        userId TEXT,
        roleId TEXT,
        lastChatId TEXT,
        lastChatTime INTEGER,
        createTime INTEGER,
        updateTime INTEGER,
        remark TEXT
      )
    ''');
  }
  /// 判断聊天记录表是否存在，不存在则创建
  /// 表名是动态的，根据用户id和角色id创建
  /// 格式 chat_$roleId_$userId
  static Future<void> createTableIfNotExists(String tableName) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chatId TEXT,
        role TEXT,
        origin INTEGER,
        content TEXT,
        voiceUrl TEXT,
        roleId TEXT,
        inputType INTEGER,
        status INTEGER,
        localStatus INTEGER,
        createTime INTEGER,
        updateTime INTEGER,
        remark TEXT
      )
    ''');
  }
}
