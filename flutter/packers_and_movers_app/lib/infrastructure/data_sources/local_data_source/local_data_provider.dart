import 'package:packers_and_movers_app/domain/models/user_signup_dto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/models/user.dart';

class LocalDataProvider {
  final int version = 1;
  late Database db;

  static final LocalDataProvider _LocalDataProvider =
      LocalDataProvider._internal();

  LocalDataProvider._internal();

  factory LocalDataProvider() {
    return _LocalDataProvider;
  }

  Future<Database> openDb() async {
    print("here");
    db = await openDatabase(
      join(await getDatabasesPath(), 'packers_and_movers2.db'),
      onCreate: (database, version) {
        database.execute(
            'CREATE TABLE user_details (Id INTEGER PRIMARY KEY, username TEXT, email TEXT, firstName TEXT, lastName TEXT, phoneNumber TEXT, role TEXT, token TEXT)');
      },
      version: version,
    );
    print("created db successfully");
    return db;
  }

  Future<Database> emptyDb() async {
    db = await openDb();
    db.execute('DELETE FROM user_details');
    return db;
  }

  Future<User> getUser() async {
    db = await openDb();
    User? user;
    try {
      print('skahsjdfhajslkfdlhs');
      // print(User.fromMap((await db.rawQuery('select * from user_details'))));
      List users = await db.rawQuery('select * from user_details');
      print(users[0]);
      user = User.fromMap(users[0] as Map<String, dynamic>);
      // user = User.fromMap((await db.rawQuery('select * from user_details'))[0]);
      print("get user $user");
    } catch (e) {
      print(e);
      throw e;
    }
    return user;
  }

  Future<String?> getToken() async {
    String? token;
    try {
      User user = await getUser();
      print("user gotten $user");
      token = user.token;
    } catch (e) {
      return null;
    }
    return token;
  }

  Future<int> addUser(User user) async {
    print("here");
    db = await openDb();
    int id;
    print("the token to be saved: ${user.token}");
    print("the role of the given user: ${user.role}");
    try {
      var x= user.toMap();
      print("THE DATA TO INSERT {$x}");
      id = await db.insert('user_details', user.toMap() as Map<String, Object?>,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw e;
    }
    return id;
  }

  Future<int> updateUser(User user) async {
    db = await openDb();
    int result;
    try {
      result = await db.update('user_details', user.toMap());
    } catch (e) {
      throw e;
    }
    return result;
  }

  Future<int> deleteUser(int id) async {
    db = await openDb();
    int result;
    try {
      result =
          await db.delete('user_details', where: 'Id = ?', whereArgs: [id]);
    } catch (e) {
      throw e;
    }
    return result;
  }
}
