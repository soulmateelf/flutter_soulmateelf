
import 'package:soulmate/dataService/model/localChatMessage.dart';
import 'package:soulmate/utils/plugin/DBUtil.dart';

/// 聊天记录service
class LocalChatMessageService {
  /// 插入单条聊天记录
  static Future<void> insertChatMessage(String tableName,LocalChatMessage localChatMessage) async {
    await DBUtil.database.insert(tableName, localChatMessage.toJson());
  }
  /// 插入多条聊天记录
  static Future<void> multipleInsertChatMessage(String tableName,List<LocalChatMessage> localChatMessageList) async {
    // 使用事务插入多行数据，以提高性能
    await DBUtil.database.transaction((txn) async {
      for (var localChatMessage in localChatMessageList) {
        await txn.insert(tableName, localChatMessage.toJson());
      }
    });
  }
  /// 获取聊天记录分页列表
  static Future<List<LocalChatMessage>> getChatMessageList(String tableName, {int? limit=10, int? page=1}) async {
    int offset = (page! - 1) * limit!;
    String query = 'SELECT * FROM $tableName order by createTime desc LIMIT $limit OFFSET $offset';
    List<Map<String, dynamic>> maps = await DBUtil.database.rawQuery(query);
    return List.generate(maps.length, (index) {
      return LocalChatMessage.fromJson(maps[index]);
    });
  }
  /// 获取单条聊天记录
  static Future<LocalChatMessage?> getChatMessageRecord(String tableName, String localChatId) async {
    List<Map<String, dynamic>> maps = await DBUtil.database.query(tableName, where: 'localChatId = ?', whereArgs: [localChatId]);
    if(maps.isNotEmpty){
      return LocalChatMessage.fromJson(maps.first);
    }
    return null;
  }
  /// 更新聊天记录
  static Future<void> updateChatMessage(String tableName, LocalChatMessage localChatMessage) async {
    await DBUtil.database.update(tableName, localChatMessage.toJson(), where: 'localChatId = ?', whereArgs: [localChatMessage.localChatId]);
  }
  /// 删除聊天记录
  static Future<void> deleteChatMessage(String tableName, String localChatId) async {
    await DBUtil.database.delete(tableName, where: 'localChatId = ?', whereArgs: [localChatId]);
  }
}