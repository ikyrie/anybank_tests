import 'package:flutter_tdd/models/account.dart';
import 'package:flutter_tdd/utils/app_exceptions.dart';
import 'package:sqflite/sqflite.dart';

import '../database.dart';

//TODO: Métodos de `findALl` e `delete` não são relevantes para o projeto.
class AccountDao {
  static const String tableSQL = 'CREATE TABLE $_tablename('
      '$_number INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_balance REAL, '
      '$_cpf TEXT'
      ');';

  static const String _tablename = "accountTable";
  static const String _number = "number";
  static const String _name = "name";
  static const String _cpf = "cpf";
  static const String _balance = "balance";

  Database? _database;

  openDatabase() async {
    _database = await getDatabase();
  }

  _verifyDatabaseOpen() {
    if (_database == null) {
      throw DatabaseNotOpenException();
    }
  }

  closeDatabase() async {
    _verifyDatabaseOpen();
    _database!.close();
  }

  save(Account account) async {
    _verifyDatabaseOpen();

    var itemExists = await findByNumber(account.number);

    Map<String, dynamic> accountMap = fromObjectToMapData(account);

    if (itemExists.isEmpty) {
      // Criar
      return await _database!.insert(_tablename, accountMap);
    } else {
      // Sobreescrever
      return await _database!.update(
        _tablename,
        accountMap,
        where: '$_number = ?',
        whereArgs: [account.number],
      );
    }
  }

  // Buscar uma conta pro número
  Future<List<Account>> findByNumber(int number) async {
    _verifyDatabaseOpen();

    final List<Map<String, dynamic>> result = await _database!.query(
      _tablename,
      where: '$_number = ?',
      whereArgs: [number],
    );

    return fromMapDataToListObject(result);
  }

  // Métodos auxiliares

  // Converte de um objeto account para um map
  Map<String, dynamic> fromObjectToMapData(Account account) {
    return {
      _number: account.number,
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
        number: lineElement[_number],
        balance: lineElement[_balance],
        cpf: lineElement[_cpf],
        name: lineElement[_name],
      );

      listAccounts.add(account);
    }

    return listAccounts;
  }
}
