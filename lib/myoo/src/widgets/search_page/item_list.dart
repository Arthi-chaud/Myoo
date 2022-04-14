import 'package:flutter/material.dart';

/// List of items to display in the search page.
/// The list is an horizontal scrollable, with a label above it
class SearchItemList<T> extends StatelessWidget {
  /// The array of items to display
  final List<T> items;
  /// The builder to *build* [Widget] from item
  final Widget Function(T item) itemBuilder;
  /// The label to display above the list
  final String label;

  const SearchItemList({Key? key, required this.items, required this.itemBuilder, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(label),
        ),
        Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items.map(
                (e) => SizedBox(
                  width: 140,
                  child: itemBuilder(e)
                )
              ).toList(),
            ),
          ),
        )
      ]
    );
  }
}
