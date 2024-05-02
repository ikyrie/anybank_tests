import 'package:flutter_tdd/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Account account;
  setUp(() {
    account = Account(
        id: 123, cpf: "333.222.333-22", balance: 100.00, name: "Beto Barros");
  });
  group("Testes de transferência", () {
    test("Testa uma transferência", () {

      account.transfer(100);
      
      expect(account.balance, 0);
    });

    test("Transferir números negativos", () {
      account.transfer(-100.0);

      expect(account.balance, 100);
    });

    test("Transferir qualquer coisa que não seja um número", () {
    });

    test("Transferir 0", () {
      account.transfer(0);

      expect(account.balance, 100);
    });

    test("Transferir mais do que disponível no saldo", () {
      account.transfer(101);

      expect(account.balance, 100);
    });

    test("Transferir quantidade nula", (){
      account.transfer(null);

      expect(account.balance, 100);
    });
  });
}
