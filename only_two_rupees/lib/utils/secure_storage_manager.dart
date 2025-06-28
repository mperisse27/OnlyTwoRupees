import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:only_two_rupees/types/store.dart';

class SecureStorageManager {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<List<Store>> readStoreList() async {
    var storeList = await _storage.read(key: 'storeList') ?? "[]";
    final List<dynamic> storeListMap = json.decode(storeList);
    return storeListMap.map((map) => Store.fromMap(map)).toList();
  }

  static Future<void> writeStoreList(List<Store> storeList) async {
    var storeListMap = storeList.map((store) => store.toMap()).toList();
    await _storage.write(key: 'storeList', value: json.encode(storeListMap));
  }

  static Future<void> addNewStoreToList(Store newStore) async {
    print(newStore);
    var storeList = await readStoreList();
    storeList.add(newStore);
    await writeStoreList(storeList);
  }

  static Future<void> editStore(Store storeToEdit) async {
    var storeList = await readStoreList();
    storeList = storeList.map((s) {
      if (s.uuid == storeToEdit.uuid) {
        return Store(s.uuid, storeToEdit.name, storeToEdit.credit,
            storeToEdit.storeType);
      }
      return s;
    }).toList();
    await writeStoreList(storeList);
  }

  static Future<void> clearAllStores() async {
    await writeStoreList([]);
  }
}
