
import 'package:soulmate/dataService/model/syncRecord.dart';
import 'package:soulmate/utils/plugin/DBUtil.dart';

/// 同步记录service
class SyncRecordService {
  /// 插入同步记录
  static Future<void> insertSyncRecord(SyncRecord syncRecord) async {
    await DBUtil.database.insert('syncRecord', syncRecord.toJson());
  }
  /// 获取所有同步记录
  static Future<List<SyncRecord>> getSyncRecordList() async {
    String query = 'SELECT * FROM syncRecord order by createTime desc';
    List<Map<String, dynamic>> maps = await DBUtil.database.rawQuery(query);
    return List.generate(maps.length, (index) {
      return SyncRecord.fromJson(maps[index]);
    });
  }
  /// 获取单条同步记录
  static Future<SyncRecord?> getSyncRecordRecord(String userId,String roleId) async {
    List<Map<String, dynamic>> maps = await DBUtil.database.query('syncRecord', where: 'userId = ? and roleId = ?', whereArgs: [userId,roleId]);
    if(maps.isNotEmpty){
      return SyncRecord.fromJson(maps.first);
    }
    return null;
  }
  /// 更新同步记录
  static Future<void> updateSyncRecord(SyncRecord syncRecord,String userId,String roleId) async {
    await DBUtil.database.update('syncRecord', syncRecord.toJson(), where: 'userId = ? and roleId = ?', whereArgs: [userId,roleId]);
  }
  /// 删除同步记录
  static Future<void> deleteSyncRecord(String userId,String roleId) async {
    await DBUtil.database.delete('syncRecord', where: 'userId = ? and roleId = ?', whereArgs: [userId,roleId]);
  }
}