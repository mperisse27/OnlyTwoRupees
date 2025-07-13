import 'package:flutter/material.dart';
import 'package:only_two_rupees/screens/compute_amounts.dart';
import 'package:only_two_rupees/screens/store_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Only 2 Rupees'),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Store List'),
            Tab(text: 'Tricount Helper'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          StoreListPage(),
          ComputeAmountsPage()
        ],
      ),
    );
  }
}