class Store {
  String name;
  int credit;

  Store(this.name, this.credit);

  void clearReduction() {
    credit = 0;
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      map['name'],
      map['credit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'credit': credit,
    };
  }
}
