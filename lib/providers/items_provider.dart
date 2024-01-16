import 'package:example_provider/providers/cart_provider.dart';
import 'package:flutter/material.dart';

class CatalogProvider extends ChangeNotifier {
  CatalogProvider() {
    _generateItemList(10);
  }
  final List<ItemCatalog> _items = [];

  List<ItemCatalog> get items => _items;

  void add() {
    _items.add(ItemCatalog(item: Item()));
    notifyListeners();
  }

  set activeItem(ItemCatalog item) {
    if (!item.active) {
      item.active = true;
      int index = _items.indexOf(item);
      if (index != -1) {
        _items[index] = item;
        notifyListeners();
      }
    }
  }

  set desActiveItem(Item item) {
    final matchingItem =
        _items.firstWhere((catalogItem) => catalogItem.item == item);
    if (matchingItem.active) {
      matchingItem.active = false;
      matchingItem.item.quantity = 0;
      notifyListeners();
    }
  }

  _generateItemList(int count) {
    for (int i = 0; i < count; i++) {
      _items.add(ItemCatalog(item: Item()));
    }
  }
}

class ItemCatalog {
  final Item item;
  bool active = false;
  ItemCatalog({required this.item});
}
