import 'dart:io';

import 'package:practica2/src/data/database/db_helper.dart';
import 'package:practica2/src/data/contracts/I_auth.dart';
import 'package:practica2/src/data/models/user.dart';

class AuthRepository implements AbstractAuthRepository {
  final _dbHelper = DBHelper();

  @override
  Future<User?> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User?> get currentUser async {
    final db = await _dbHelper.database;
    final result = await db!.query(_dbHelper.userTable);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  @override
  Future<User> editProfile({
    String? nombre,
    String? aPaterno,
    String? aMaterno,
    String? foto,
    String? email,
    String? about,
    String? telefono,
  }) async {
    final db = await _dbHelper.database;
    User? user = await currentUser;
    if (user == null) {
      user = User(
        nombre: nombre,
        aPaterno: aPaterno,
        aMaterno: aMaterno,
        foto: foto,
        email: email,
        about: about,
        telefono: telefono,
      );
      await db!.insert(_dbHelper.userTable, user.toMap());
    } else {
      if (foto != null && user.foto != null) {
        final oldFoto = File(user.foto!);
        if (oldFoto.existsSync()) oldFoto.deleteSync();
      }
      user = user.copyWith(
        nombre: nombre,
        aPaterno: aPaterno,
        aMaterno: aMaterno,
        foto: foto,
        email: email,
        about: about,
        telefono: telefono,
      );
      await db!.update(_dbHelper.userTable, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    }
    return user;
  }
}
