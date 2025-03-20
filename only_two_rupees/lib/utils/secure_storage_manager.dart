import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:only_two_rupees/types/store.dart';

class SecureStorageManager {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<List<Store>> readStoreList(String key) async {
    var storeList = await _storage.read(key: 'storeList') ?? "[]";
    final List<dynamic> storeListMap = json.decode(storeList);
    return storeListMap.map((map) => Store.fromMap(map)).toList();
  }

  static Future<void> writeStoreList(String key, List<Store> storeList) async {
    var storeListMap = storeList.map((store) => store.toMap()).toList();
    await _storage.write(key: 'storeList', value: json.encode(storeListMap));
  }
}