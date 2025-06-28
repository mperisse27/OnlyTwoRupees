enum StoreType {
  laundry,
  fastfood,
  restaurant,
  groceries,
  clothes
}

class Store {
  String uuid;
  String name;
  int credit;
  StoreType storeType;


  Store(this.uuid, this.name, this.credit, this.storeType);

  void clearReduction() {
    credit = 0;
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      map['uuid'],
      map['name'],
      map['credit'],
      StoreType.values[map['storeType']],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'credit': credit,
      'storeType': storeType.index,
    };
  }
}
