import 'package:example_provider/providers/cart_provider.dart';
import 'package:example_provider/providers/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerPage extends StatefulWidget {
  static String routeName = "ConsumerPage";
  const ConsumerPage({super.key});

  @override
  State<ConsumerPage> createState() => _ConsumerPageState();
}

class _ConsumerPageState extends State<ConsumerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Total price: \$${context.watch<CartProvider>().totalPrice}',
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ),
        body: ListView.builder(
          itemCount: context.watch<CartProvider>().items.length,
          itemBuilder: (BuildContext context, int index) {
            return itemShoping(context.watch<CartProvider>().items[index]);
          },
        ));
  }

  Widget itemShoping(Item item, {double dimension = 40}) => Dismissible(
        key: Key(item.name),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          context.read<CatalogProvider>().desActiveItem = item;
          context.read<CartProvider>().remove(item);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Item dismissed: ${item.name}')),
          );
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: ListTile(
          leading: Container(
            color: item.color,
            height: dimension,
            width: dimension,
          ),
          title: Text(item.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("cost \$${item.price}"),
              Text("Total \$${item.price * item.quantity}"),
            ],
          ),
          trailing: IconButton(
            icon: Text(item.quantity.toString()),
            onPressed: () {
              context.read<CartProvider>().add(item);
            },
          ),
        ),
      );
}
