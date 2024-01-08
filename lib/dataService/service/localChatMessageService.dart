
import 'package:soulmate/dataService/model/localChatMessage.dart';
import 'package:soulmate/utils/plugin/DBUtil.dart';
import 'package:soulmate/utils/tool/utils.dart';

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
  /// 本来我是写的按照page和limit来分页的，但是如果请求第一页数据之后继续聊天，数据库记录持续增加，
  /// 再请求第二页数据，这时候第二页数据就会有重复的，所以改成了按照localChatId来分页
  static Future<List<LocalChatMessage>> getChatMessageList(String tableName, {String? lastLocalChatId,int? limit=10}) async {
    String query = 'SELECT * FROM $tableName order by createTime desc LIMIT $limit';
    if(!Utils.isEmpty(lastLocalChatId)){
      query = 'SELECT * FROM $tableName where createTime < (select createTime from $tableName where localChatId = "$lastLocalChatId") order by createTime desc LIMIT $limit';
    }
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
  /// 删除所有聊天记录
  static Future<void> clearChatMessageByRoleId(String tableName) async {
    await DBUtil.database.delete(tableName);
  }
}