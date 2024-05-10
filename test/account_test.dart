import 'package:flutter_tdd/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Account account;
  setUp(() {
    account = Account(
        id: 123, cpf: "333.222.333-22", balance: 100.00, name: "Beto Barros");
  });

  group("Account Transfer Testes", () {
    test("Deve atualizar o saldo corretamente após uma transferência válida", () {
      account.transfer(100);
      
      expect(account.balance, 0);
    });

    test("Deve lançar InvalidAmountException quando o valor é menor ou igual a zero", () {
      expect(() => account.transfer(0), throwsA(isA<InvalidAmountException>()));
      expect(() => account.transfer(-100), throwsA(isA<InvalidAmountException>()));
    });

    test("Deve lançar InsufficientBalanceException quando o valor é maior do que o saldo", () {
      expect(() => account.transfer(101), throwsA(isA<InsufficientBalanceException>()));
    });

    test("Deve lançar NullAmountException quando o valor é nulo", (){
      expect(() => account.transfer(null), throwsA(isA<NullAmountException>()));
    });

  });

  group("Account interest rates", () {
    test("Deve-se aplicar um juros de 1% quando o tipo de conta for conta corrente", () {
      account.applyInterest();
      expect(account.balance, 101);
    });

    test("Deve-se aplicar um juros de 3% quando o tipo de conta for poupança", () {
      Account savingsAccount = Account(id: 1, cpf: "333.333.333-33", balance: 100, name: "Ademir de Barros", accountType: AccountType.savings);
      savingsAccount.applyInterest();
      expect(savingsAccount.balance, 103);
    });
  });
}
