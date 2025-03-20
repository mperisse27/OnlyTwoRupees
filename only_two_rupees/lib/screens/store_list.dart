import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:only_two_rupees/types/store.dart';
import 'package:only_two_rupees/utils/secure_storage_manager.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  List<Store> storeList = [];

  void loadStoreList() async {
    var newStores = await SecureStorageManager.readStoreList('storeList');
    setState(() {
      storeList = newStores;
    });
  }

  @override
  void initState() {
    loadStoreList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnlyTwoRupees'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Store 0'),
            onTap: () {
              // Navigator.of(context).pushNamed('/details');
            },
          ),
          ListTile(
            title: const Text('Store 2'),
            onTap: () {
              // Navigator.of(context).pushNamed('/details');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        tooltip: 'Add new store',
        child: const Icon(Icons.add),
      ),
    );
  }
}
