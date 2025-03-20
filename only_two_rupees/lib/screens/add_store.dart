import 'package:flutter/material.dart';

class AddStorePage extends StatefulWidget {
  const AddStorePage({super.key});

  @override
  State<AddStorePage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<AddStorePage> {
  String storeName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnlyTwoRupees'),
        backgroundColor: Colors.green,
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add Store',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Store Name',
              ),
              onChanged: (value) => setState(() {
                storeName = value;
              }),
            ),
          ],
        ),
      )
    );
  }
}
