import 'package:flutter_tdd/models/account.dart';
import 'package:flutter_tdd/utils/app_exceptions.dart';
import 'package:sqflite/sqflite.dart';

import '../database.dart';

//TODO: Métodos de `findALl` e `delete` não são relevantes para o projeto.
class AccountDao {
  static const String tableSQL = 'CREATE TABLE $_tablename('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_balance REAL, '
      '$_cpf TEXT'
      ');';

  static const String _tablename = "accountTable";
  static const String _id = "id";
  static const String _name = "name";
  static const String _cpf = "cpf";
  static const String _balance = "balance";

  Database? database;

  openDatabase(Database currentDatabase) async {
    database = await getDatabase();
  }

  _verifyDatabaseOpen() {
    if (database == null) {
      throw DatabaseNotOpenException();
    }
  }

  closeDatabase() async {
    _verifyDatabaseOpen();
    database!.close();
  }

  Future<int> save(Account account) async {
    _verifyDatabaseOpen();

    var itemExists = await findById(account.id);

    Map<String, dynamic> accountMap = fromObjectToMapData(account);

    if (itemExists.isEmpty) {
      // Criar
      return await database!.insert(_tablename, accountMap);
    } else {
      // Sobreescrever
      return await database!.update(
        _tablename,
        accountMap,
        where: '$_id = ?',
        whereArgs: [account.id],
      );
    }
  }

  // Buscar uma conta pro número
  Future<List<Account>> findById(int id) async {
    _verifyDatabaseOpen();

    final List<Map<String, dynamic>> result = await database!.query(
      _tablename,
      where: '$_id = ?',
      whereArgs: [id],
    );

    return fromMapDataToListObject(result);
  }

  // Métodos auxiliares

  // Converte de um objeto account para um map
  Map<String, dynamic> fromObjectToMapData(Account account) {
    return {
      _id: account.id,
      _name: account.name,
      _cpf: account.cpf,
      _balance: account.balance,
    };
  }

  // Converte do map recebido para uma lista de Account
  List<Account> fromMapDataToListObject(List<Map<String, dynamic>> map) {
    final List<Account> listAccounts = [];

    for (Map<String, dynamic> lineElement in map) {
      final Account account = Account(
        id: lineElement[_id],
        balance: lineElement[_balance],
        cpf: lineElement[_cpf],
        name: lineElement[_name],
      );

      listAccounts.add(account);
    }

    return listAccounts;
  }
}
