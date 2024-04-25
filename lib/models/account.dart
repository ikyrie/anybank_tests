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

}
