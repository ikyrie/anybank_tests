import 'dart:math';

import 'package:flutter_tdd/data/daos/account_dao.dart';
import 'package:flutter_tdd/data/daos/transfer_dao.dart';
import 'package:flutter_tdd/data/database.dart';
import 'package:flutter_tdd/models/account.dart';
import 'package:flutter_tdd/models/transfer.dart';
import 'package:sqflite/sqflite.dart';

Future<void> setDemoDatabase() async {
  Database database = await getDatabase();
  int? countAccounts = Sqflite.firstIntValue(
    await database.rawQuery("SELECT COUNT('number') FROM 'accountTable'"),
  );

  int? countTransfers = Sqflite.firstIntValue(
    await database.rawQuery("SELECT COUNT('number') FROM 'accountTable'"),
  );

  if (countAccounts != null &&
      countAccounts != 0 &&
      countTransfers != null &&
      countTransfers != 0) {
    return;
  }

  AccountDao accountDao = AccountDao();
  await accountDao.openDatabase();

  List<Account> someAccounts = [
    Account(
      number: 1111,
      cpf: "000.111.222-33",
      balance: 856.34,
      name: "Matheus Alberto",
    ),
    Account(
      number: 2222,
      cpf: "444.555.666-77",
      balance: 355.60,
      name: "Ricarth Lima",
    ),
    Account(
      number: 3333,
      cpf: "888.999.000-11",
      balance: 1234.56,
      name: "Mariana Helena",
    ),
    Account(
      number: 4444,
      cpf: "222.333.444-55",
      balance: 3141.5,
      name: "João Melo",
    ),
  ];

  for (Account account in someAccounts) {
    await accountDao.save(account);
  }

  await accountDao.closeDatabase();

  TransferDao transferDao = TransferDao();
  await transferDao.openDatabase();

  List<Transferr> someTrasfers = [
    Transferr(
      id: 0,
      numberSender: someAccounts[0].number,
      numberReceiver: someAccounts[1].number,
      amount: Random().nextInt(30) + 20,
      date: DateTime.now().subtract(
        Duration(
          days: Random().nextInt(60),
          seconds: Random().nextInt(36000),
        ),
      ),
    ),
    Transferr(
      id: 0,
      numberSender: someAccounts[0].number,
      numberReceiver: someAccounts[2].number,
      amount: Random().nextInt(30) + 20,
      date: DateTime.now().subtract(
        Duration(
          days: Random().nextInt(60),
          seconds: Random().nextInt(36000),
        ),
      ),
    ),
    Transferr(
      id: 0,
      numberSender: someAccounts[0].number,
      numberReceiver: someAccounts[3].number,
      amount: Random().nextInt(30) + 20,
      date: DateTime.now().subtract(
        Duration(
          days: Random().nextInt(60),
          seconds: Random().nextInt(36000),
        ),
      ),
    ),
    Transferr(
      id: 0,
      numberSender: someAccounts[3].number,
      numberReceiver: someAccounts[0].number,
      amount: Random().nextInt(30) + 20,
      date: DateTime.now().subtract(
        Duration(
          days: Random().nextInt(60),
          seconds: Random().nextInt(36000),
        ),
      ),
    ),
    Transferr(
      id: 0,
      numberSender: someAccounts[2].number,
      numberReceiver: someAccounts[0].number,
      amount: Random().nextInt(30) + 20,
      date: DateTime.now().subtract(
        Duration(
          days: Random().nextInt(60),
          seconds: Random().nextInt(36000),
        ),
      ),
    ),
    Transferr(
      id: 0,
      numberSender: someAccounts[1].number,
      numberReceiver: someAccounts[0].number,
      amount: Random().nextInt(30) + 20,
      date: DateTime.now().subtract(
        Duration(
          days: Random().nextInt(60),
          seconds: Random().nextInt(36000),
        ),
      ),
    ),
  ];

  for (Transferr transferr in someTrasfers) {
    await transferDao.save(transferr);
  }

  await transferDao.closeDatabase();
}
