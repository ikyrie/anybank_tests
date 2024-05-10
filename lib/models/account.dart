// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum AccountType {
  checking,
  savings
}

class NullAmountException implements Exception {
  @override
  String toString() => "O valor não pode ser nulo.";
}

class InsufficientBalanceException implements Exception {
  @override
  String toString() => "Saldo insuficiente para completar a transação.";
}

class InvalidAmountException implements Exception {
  @override
  String toString() => "O valor deve ser maior que zero.";
}
class Account {
  final int id;
  final String name;
  final String cpf;
  double balance;
  final AccountType accountType;

  Account({
    required this.id,
    required this.cpf,
    required this.balance,
    required this.name,
    this.accountType = AccountType.checking,
  });

  void transfer(double? amount) {
    if (amount == null) {
      throw NullAmountException();
    }
    if (amount > balance) {
      throw InsufficientBalanceException();
    }
    if (amount <= 0) {
      throw InvalidAmountException();
    }
    balance = balance - amount;
  }

  void applyInterest() {
    double interest = (accountType == AccountType.checking) ? 0.01 : 0.03;
    balance += balance * interest;
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cpf': cpf,
      'balance': balance,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as int,
      name: map['name'] as String,
      cpf: map['cpf'] as String,
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);
}
