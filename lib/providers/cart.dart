import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ShoppingListProvider extends StateNotifier<List<String>> {
  _ShoppingListProvider() : super(<String>[]);

  /// If watch listeners do not react to changes automatically,
  /// then use this function to notify all watch listeners
  void notifyListeners() {
    final List<String> savedShoppingList = state;
    state = <String>[];
    state = savedShoppingList;
  }
}

final ShoppingListProvider =
    StateNotifierProvider<_ShoppingListProvider, List<String>>(
        (ref) => _ShoppingListProvider());
