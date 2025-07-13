import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:only_two_rupees/types/store.dart';
import 'package:only_two_rupees/utils/secure_storage_manager.dart';
import 'package:uuid/uuid.dart';

class StoreDetailsPage extends StatefulWidget {
  const StoreDetailsPage({super.key});

  @override
  State<StoreDetailsPage> createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  List<Store> storeList = [];
  bool isLoading = true;

  final TextEditingController _creditController = TextEditingController();

  Future<void> loadStore() async {
    var newStores = await SecureStorageManager.readStoreList();
    setState(() {
      storeList = newStores;
      isLoading = false;
    });
  }

  Future<void> editCredit(Store store, String newCredit) async {
    var newStore = store;
    newStore.credit = int.parse(newCredit);
    await SecureStorageManager.editStore(newStore);
  }

  String getImageFromStoreType(StoreType type) {
    switch (type) {
      case StoreType.laundry:
        return 'assets/images/laundry.png';
      case StoreType.fastfood:
        return 'assets/images/fastfood.png';
      case StoreType.restaurant:
        return 'assets/images/restaurant.png';
      case StoreType.groceries:
        return 'assets/images/groceries.png';
      case StoreType.clothes:
        return 'assets/images/clothes.png';
    }
  }

  @override
  void initState() {
    super.initState();
    loadStore();
  }

  @override
  Widget build(BuildContext context) {
    final String? id = GoRouterState.of(context).pathParameters['id'];
    final Store store = isLoading
        ? Store(Uuid().v4(), "", 0, StoreType.clothes)
        : storeList.firstWhere((store) => store.uuid == id);
    _creditController.text = '${store.credit}';
    if (id == null) {
      return const Scaffold(body: Text('Error'));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("OnlyTwoRupees"),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
      ? const Center(child: CircularProgressIndicator())
      : Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 200,
              height: 200,
              image: AssetImage(
                getImageFromStoreType(store.storeType),
              )
            ),
            const SizedBox(
              height: 24,
            ),
            Text(store.name, style: const TextStyle(fontSize: 48)),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                const Text(
                  'Credit: ',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                      controller: _creditController,
                      style: const TextStyle(fontSize: 24)),
                ),
                IconButton(
                    onPressed: () =>
                        editCredit(store, _creditController.text),
                    icon: const Icon(Icons.check))
              ],
            ),
          ],
        ),
      ));
  }
}
