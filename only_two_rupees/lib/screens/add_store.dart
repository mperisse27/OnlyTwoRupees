import 'package:flutter/material.dart';
import 'package:only_two_rupees/types/store.dart';
import 'package:only_two_rupees/utils/secure_storage_manager.dart';
import 'package:uuid/uuid.dart';

class AddStorePage extends StatefulWidget {
  const AddStorePage({super.key});

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _creditController = TextEditingController();
  StoreType _storeType = StoreType.fastfood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OnlyTwoRupees'),
          backgroundColor: Colors.green,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Add Store',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Store Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  controller: _creditController,
                  decoration: const InputDecoration(
                    labelText: 'Initial credit',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid number';
                    }
                    try {
                      int.parse(value);
                      return (int.parse(value) >= 0
                          ? null
                          : 'Please enter a positive number');
                    } catch (e) {
                      return 'Please enter a valid number';
                    }
                  },
                ),
              ),
              DropdownButton(
                style: const TextStyle(color: Colors.black),
                hint: Text(_storeType.name),
                items: StoreType.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (e) => setState(() {
                  _storeType = e as StoreType;
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Processing Data')),
                    // );
                    SecureStorageManager.addNewStoreToList(Store(
                        const Uuid().v4(),
                        _nameController.text,
                        int.parse(_creditController.text),
                        _storeType));
                  }
                },
                child: const Text('Add new store'),
              ),
              ElevatedButton(
                onPressed: () {
                  SecureStorageManager.clearAllStores();
                },
                child: const Text('Clear stores'),
              ),
            ],
          ),
        ));
  }
}
