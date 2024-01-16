import 'package:example_provider/pages/consumer_page.dart';
import 'package:example_provider/providers/cart_provider.dart';
import 'package:example_provider/providers/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatefulWidget {
  static String routeName = "CatalogPage";
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
        backgroundColor: Colors.amberAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.pushNamed(context, ConsumerPage.routeName);
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: context.watch<CatalogProvider>().items.length,
          itemBuilder: (BuildContext context, int index) {
            return cardItem(context.watch<CatalogProvider>().items[index]);
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.read<CatalogProvider>().add();
          }),
    );
  }

  ListTile cardItem(ItemCatalog itemCatalog, {double dimension = 40}) {
    return ListTile(
      leading: Container(
        color: itemCatalog.item.color,
        height: dimension,
        width: dimension,
      ),
      title: Text(itemCatalog.item.name),
      subtitle: Text("#${itemCatalog.item.id}"),
      trailing: IconButton(
          onPressed: () {
            context.read<CartProvider>().add(itemCatalog.item);
            context.read<CatalogProvider>().activeItem = itemCatalog;
          },
          icon: itemCatalog.active
              ? Badge.count(
                  count: context
                      .watch<CartProvider>()
                      .item(itemCatalog.item)
                      .quantity,
                  child: const Icon(Icons.check))
              : const Icon(Icons.add)),
    );
  }
}
