import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    this.onSearchChanged,
    this.hintText,
    this.borderRadius = 10,
    this.onSearchCleared,
  }) : super();

  final void Function(String)? onSearchChanged;
  final void Function()? onSearchCleared;

  final double borderRadius;

  final String? hintText;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.4, color: Theme.of(context).dividerColor.withOpacity(0.5)),
        borderRadius: BorderRadius.all(
          Radius.circular(widget.borderRadius),
        ),
        color: Colors.white54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Opacity(
            opacity: 0.7,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: widget.hintText ?? 'Search...',
              ),
              onChanged: widget.onSearchChanged ??
                  (_) => print('no function provided'),
            ),
          ),
          Opacity(
            opacity: 0.7,
            child: IconButton(
              splashRadius: 5,
              padding: EdgeInsets.zero,
              icon: Icon(controller.value.text.isNotEmpty
                  ? Icons.cancel
                  : Icons.cancel_outlined),
              onPressed: () {
                if (controller.value.text.isNotEmpty) {
                  controller.clear();
                  widget.onSearchCleared!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
