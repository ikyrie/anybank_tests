import 'package:flutter_tdd/models/transfer.dart';
import 'package:flutter_tdd/utils/app_exceptions.dart';
import 'package:sqflite/sqflite.dart';

import '../database.dart';

//TODO: Método `delete` não é relevante para o projeto.
class TransferDao {
  static const String tableSQL = 'CREATE TABLE $_tablename('
      '$_id INTEGER PRIMARY KEY, '
      '$_numberSender INTEGER, '
      '$_numberReceiver INTEGER, '
      '$_amount REAL, '
      '$_date DATETIME, '
      'FOREIGN KEY ($_numberSender) REFERENCES Account(number),'
      'FOREIGN KEY ($_numberReceiver) REFERENCES Account(number)'
      ');';

  static const String _tablename = "transferTable";
  static const String _id = "uid";
  static const String _numberSender = "numberSender";
  static const String _numberReceiver = "numberReceiver";
  static const String _amount = "amount";
  static const String _date = "date";

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

  save(Transferr transfer) async {
    _verifyDatabaseOpen();

    var itemExists = await findById(transfer.id);

    Map<String, dynamic> transferMap = fromObjectToMapData(transfer);

    if (itemExists.isEmpty) {
      // Criar
      return await _database!.insert(_tablename, transferMap);
    } else {
      // Sobreescrever
      return await _database!.update(
        _tablename,
        transferMap,
        where: '$_id = ?',
        whereArgs: [transfer.id],
      );
    }
  }

  // Busca todas as transferências
  Future<List<Transferr>> findAll() async {
    _verifyDatabaseOpen();

    final List<Map<String, dynamic>> result =
        await _database!.query(_tablename);

    return fromMapDataToListObject(result);
  }

  // Buscar uma transferencia por ID
  Future<List<Transferr>> findById(int id) async {
    _verifyDatabaseOpen();

    final List<Map<String, dynamic>> result = await _database!.query(
      _tablename,
      where: '$_id = ?',
      whereArgs: [id],
    );

    return fromMapDataToListObject(result);
  }

  // Métodos auxiliares

  // Converte de um objeto transfer para um map
  Map<String, dynamic> fromObjectToMapData(Transferr transfer) {
    return {
      _id: transfer.id,
      _numberSender: transfer.numberSender,
      _numberReceiver: transfer.numberReceiver,
      _amount: transfer.amount,
      _date: transfer.date,
    };
  }

  // Converte do map recebido para uma lista de Transfer
  List<Transferr> fromMapDataToListObject(List<Map<String, dynamic>> map) {
    final List<Transferr> listTransfers = [];

    for (Map<String, dynamic> lineElement in map) {
      final Transferr transfer = Transferr(
        id: lineElement[_id],
        numberReceiver: lineElement[_numberReceiver],
        numberSender: lineElement[_numberSender],
        amount: lineElement[_amount],
        date: lineElement[_date],
      );

      listTransfers.add(transfer);
    }

    return listTransfers;
  }
}
