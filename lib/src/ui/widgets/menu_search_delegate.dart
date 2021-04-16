import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/restaurant/widgets/restaurant_menu.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_icon_button.dart';

class MenuSearchDelegate<T> extends SearchDelegate<T?> {
  MenuSearchDelegate({this.items, this.filter});

  final List<T>? items;
  final bool Function(T, String)? filter;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.white,
          ),
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            border: InputBorder.none,
          ),
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        color: Colors.black87,
        padding: const EdgeInsets.only(right: 9),
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          child: ScaleTransition(
            scale: transitionAnimation,
            child: query.isEmpty
                ? const Icon(
                    Icons.cancel_outlined,
                    key: ValueKey<int>(0),
                  )
                : const Icon(
                    Icons.cancel,
                    key: ValueKey<int>(1),
                  ),
          ),
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  static final Tween<double> _heightTween = Tween<double>(begin: 200, end: 100);

  // @override
  // PreferredSizeWidget buildBottom(BuildContext context) {
  //   return PreferredSize(
  //     preferredSize: Size.fromHeight(200),
  //     child: SizeTransition(
  //       sizeFactor: transitionAnimation,
  //       axisAlignment: 10,
  //       child: Container(
  //         height: 200,
  //         color: Colors.red,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: CustomIconButton(
        backgroundColor: Colors.black12,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    showSuggestions(context);
    final List<T> results =
        items!.where((T item) => filter!(item, query)).toList();
    if (results.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              'No Results Found.',
            ),
          ),
        ],
      );
    }
    return CustomScrollView(
      slivers: <Widget>[
        RestaurantMenu(
          menu: results as List<ItemCategory>,
        )
      ],
    );

    // return ListView.builder(
    //   itemCount: results.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return CategoryItems(
    //       category: results[index] as ItemCategory,
    //     );
    //   },
    // );
  }
}
