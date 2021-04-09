import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/item_category.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_tab_indicator.dart';

class CategoriesTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoriesTabBar({
    Key? key,
    this.categories,
    this.maxHeight,
    this.heightFactor,
    this.onTabSelected,
    this.tabController,
  }) : super(key: key);

  final List<ItemCategory>? categories;
  final double? maxHeight;
  final double? heightFactor;
  final void Function(int)? onTabSelected;
  final TabController? tabController;

  List<Widget> _buildTabItems(List<ItemCategory> categories) {
    return List<Widget>.generate(
      categories.length,
      (int index) => Tab(
        child: Container(
          /// This margin approximately aligns text to indicator
          margin: const EdgeInsets.only(top: 2.5),
          alignment: Alignment.center,
          child: Text(
            categories[index].title!['en']!.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        heightFactor: heightFactor,
        child: Container(
          padding: const EdgeInsets.only(bottom: 13),
          height: maxHeight,
          child: Opacity(
            opacity: Curves.easeInQuint.transform(heightFactor!),
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: TabBar(
                isScrollable: true,
                onTap: onTabSelected,
                unselectedLabelColor: Colors.grey.shade700,
                indicator: CustomTabIndicator(
                  indicatorHeight: 25.0,
                  indicatorColor: Theme.of(context).highlightColor,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Theme.of(context).primaryColor,
                controller: tabController,
                tabs: _buildTabItems(categories!),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(maxHeight!);
}
