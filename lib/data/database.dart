import 'package:flutter_tdd/data/daos/account_dao.dart';
import 'package:flutter_tdd/data/daos/transfer_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'anybank.db');
  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(AccountDao.tableSQL);
      await db.execute(TransferDao.tableSQL);
    },
    version: 1,
  );
}
