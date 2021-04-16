import 'package:equatable/equatable.dart';

import 'menu_item.dart';

class ItemCategory extends Equatable {
  final String name;
  final List<MenuItem> items;

  const ItemCategory(this.name, this.items);

  @override
  List<Object?> get props => <Object?>[name, items];
}
