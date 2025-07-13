import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:only_two_rupees/screens/add_store.dart';
import 'package:only_two_rupees/screens/home.dart';
import 'package:only_two_rupees/screens/store_details.dart';
import 'package:only_two_rupees/screens/store_list.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}


final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:id',
          builder: (BuildContext context, GoRouterState state) {
            return const StoreDetailsPage();
          },
        ),
        GoRoute(
          path: 'add',
          builder: (BuildContext context, GoRouterState state) {
            return const AddStorePage();
          },
        ),
      ],
    ),
  ],
);
