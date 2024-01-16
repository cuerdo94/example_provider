import 'package:example_provider/pages/catalog_page.dart';
import 'package:example_provider/pages/consumer_page.dart';
import 'package:example_provider/providers/cart_provider.dart';
import 'package:example_provider/providers/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => CatalogProvider()),
    ], child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Provider',
      initialRoute: CatalogPage.routeName,
      routes: {
        CatalogPage.routeName: (_) => const CatalogPage(),
        ConsumerPage.routeName: (_) => const ConsumerPage()
      },
    );
  }
}
