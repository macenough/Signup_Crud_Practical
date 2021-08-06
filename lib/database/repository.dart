import 'package:signup_login_demo/model/signup_model.dart';
import 'db_helper.dart';

class Repository {
  Future<UserModel> add(UserModel userModel) async {
    var dbClient = await db;
    final result = await dbClient!
        .insert(DataBaseHelper.appointmentTable, userModel.toMap());
    print(result.toString());
    return userModel;
  }

  Future<List<UserModel>> getUserInfo(String emailid, String password) async {
    final data = await db!.query(DataBaseHelper.appointmentTable,
        where: "${DataBaseHelper.email} = ? and ${DataBaseHelper.password} = ?",
        whereArgs: [emailid, password]);
    print(data.toString());
    var list = <UserModel>[];
    list.addAll(data.map((c) => UserModel.fromMap(c)).toList());
    return list;
  }

  Future<bool> isAlreadyEmailCheck(String emailid) async {
    final data = await db!.query(DataBaseHelper.appointmentTable,
        where: '${DataBaseHelper.email} = ?', whereArgs: [emailid]);
    print(data.toString());
    if (data.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<int> update(int id, String name, String occ) async {
    var dbClient = await db;
    return await dbClient!.rawUpdate('''
    UPDATE ${DataBaseHelper.appointmentTable} 
    SET ${DataBaseHelper.name} = ?, ${DataBaseHelper.occupation} = ? 
    WHERE ${DataBaseHelper.id} = ?
    ''', [name, occ, id]);
  }
}
