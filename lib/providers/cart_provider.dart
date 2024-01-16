import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:math';

class CartProvider extends ChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  Item item(item) =>
      _items.firstWhere((existingItem) => existingItem.name == item.name,
          orElse: () => item);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void add(Item item) {
    Item existingItem = _items.firstWhere(
        (existingItem) => existingItem.name == item.name,
        orElse: () => item);

    if (item.quantity != 0) {
      existingItem.quantity += 1;
    } else {
      item.quantity = 1;
      _items.add(item);
    }

    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}

class Item {
  String id;
  Color color;
  String name;
  double price;
  int quantity;

  Item({
    this.quantity = 0,
  })  : id = _generateUniqueId(),
        color = _generateRandomColor(),
        name = _generateRandomName(),
        price = _generateRandomPrice();

  static String _generateUniqueId() {
    Random random = Random();
    int uniquePart = random.nextInt(1000000);

    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch.toString();

    String uniqueId = '$timestamp-$uniquePart';
    return uniqueId;
  }

  static Color _generateRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);

    return Color.fromARGB(255, r, g, b);
  }

  static String _generateRandomName() {
    List<String> names = [
      'Alice',
      'Bob',
      'Charlie',
      'David',
      'Eva',
      'Frank',
      'Grace',
      'Hank',
      'Ivy',
      'Jack',
    ];

    Random random = Random();
    return names[random.nextInt(names.length)];
  }

  static double _generateRandomPrice() {
    Random random = Random();
    return (random.nextDouble() * 90) + 10;
  }
}
