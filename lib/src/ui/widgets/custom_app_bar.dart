import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';

import 'custom_icon_button.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  CustomAppBar({
    required this.minExtent,
    required this.maxExtent,
    this.showBackButton = true,
    this.title,
    this.trailing,
  });
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final bool showBackButton;
  final String? title;
  final Widget? trailing;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double t = Curves.easeInOut.transform(shrinkRatio(shrinkOffset));
    final Offset tittleOffset = Offset(0, lerpDouble(0, 8, t)!);
    final Color? bgColor = ColorTween(
            begin: Colors.white, end: Theme.of(context).scaffoldBackgroundColor)
        .lerp(shrinkRatio(shrinkOffset));

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          elevation: minToZeroShrinkRatio(shrinkOffset) * 4,
          backgroundColor: bgColor,
          leadingWidth: 40,
          titleSpacing: 0,
          title: Row(
            children: <Widget>[
              horizontalAppPaddingSpace,
              Visibility(
                visible: showBackButton,
                child: CustomIconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  backgroundColor: Colors.black.withOpacity(0.1),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Visibility(
                visible: title != null,
                child: Transform.translate(
                  offset: tittleOffset,
                  child: Padding(
                    padding: EdgeInsets.only(left: showBackButton ? 10 : 0),
                    child: Opacity(
                      opacity: minToZeroShrinkRatio(shrinkOffset),
                      child: Text(
                        title ?? noValueString,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Visibility(
              visible: trailing != null,
              child: trailing!,
            ),
            horizontalAppPaddingSpace,
          ],
        ),
      ],
    );
  }

  double shrinkRatio(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  double minToZeroShrinkRatio(double shrinkOffset) {
    return 1.0 - min(1.0, max(0.0, maxExtent - shrinkOffset) / minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
