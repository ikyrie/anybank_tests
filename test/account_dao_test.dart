import 'package:flutter_tdd/data/daos/account_dao.dart';
import 'package:flutter_tdd/models/account.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<Database>()])
import 'account_dao_test.mocks.dart';

void main() {
  group("Testando o banco de dados", () {
    late AccountDao accountDao;
    late MockDatabase mockDatabase;
    late Account account;
    setUp(() {
      accountDao = AccountDao();
      mockDatabase = MockDatabase();
      accountDao.database = mockDatabase;
      account = Account(id: 1, cpf: "333.333.333-33", balance: 100, name: "Beto Barros"); 
    });

    test("Save account to database Test", () async {
      when(mockDatabase.query(
        any,
        where: anyNamed("where"),
        whereArgs: anyNamed("whereArgs"),
      )).thenAnswer((_) async => []);

      await accountDao.save(account);

      verify(mockDatabase.insert('accountTable', any)).called(1);
      verifyNever(mockDatabase.update(any, any));
    });

    test("Save account to database Test", () async {
      when(mockDatabase.query(
        any,
        where: anyNamed("where"),
        whereArgs: anyNamed("whereArgs"),
      )).thenAnswer((_) async => [account.toMap()]);

      await accountDao.save(account);

      verify(mockDatabase.update('accountTable', any, where: anyNamed('where'),
        whereArgs: anyNamed('whereArgs'))).called(1);
      verifyNever(mockDatabase.insert(any, any));
    });
  });
}
