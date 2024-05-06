// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Account {
  final int id;
  final String name;
  final String cpf;
  double balance;

  Account({
    required this.id,
    required this.cpf,
    required this.balance,
    required this.name,
  });

  void transfer(double? amount) {
    if (amount != null) {
      if (amount <= balance && amount > 0) {
        balance = balance - amount;
      }
    }
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
