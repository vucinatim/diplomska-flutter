import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_menu_flutter/src/models/menu_item.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_icon_button.dart';

class ExpandableMenuItem extends StatefulWidget {
  const ExpandableMenuItem({
    Key? key,
    this.item,
    this.language = 'en',
    this.isExpanded = false,
    this.onTap,
  }) : super(key: key);

  final MenuItem? item;
  final String language;
  final bool isExpanded;
  final VoidCallback? onTap;

  @override
  State<StatefulWidget> createState() => _ExpandableMenuItemState();
}

class _ExpandableMenuItemState extends State<ExpandableMenuItem> {
  NumberFormat f = NumberFormat('#,##0.00', 'sl');

  Widget _buildInfo() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.item?.name ?? noValueString,
            overflow: TextOverflow.ellipsis,
            maxLines: widget.isExpanded ? 2 : 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceTiny,
          Text(
            widget.item?.description ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: widget.isExpanded ? 3 : 2,
          ),
          verticalSpaceTiny,
          Text(
            '${f.format(widget.item?.price).toString()} \€',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCollapsedImage() {
    return Container(
      width: 70,
      height: 70,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.antiAlias,
        child: widget.item?.image != null
            ? Image.network(widget.item!.image!)
            : const Icon(Icons.help_center),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.antiAlias,
              child: widget.item?.image != null
                  ? Image.network(widget.item!.image!)
                  : const Icon(Icons.help_center),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: CustomIconButton(
                icon: const Icon(Icons.close),
                backgroundColor: Colors.white24,
                onPressed: widget.onTap,
              ),
            ),
          ],
        )
      ],
    );
  }

  final Tween<Offset> _offsetTween =
      Tween<Offset>(begin: const Offset(-200, 0), end: const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            AnimatedSwitcher(
              switchInCurve: Curves.fastOutSlowIn,
              switchOutCurve: Curves.easeInOutQuad,
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(child: child, sizeFactor: animation),
                );
              },
              child: widget.isExpanded ? _buildHeader() : Container(),
            ),
            Container(
              height: widget.isExpanded ? null : 95,
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalAppPadding, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildInfo(),
                  AnimatedSwitcher(
                    switchInCurve: Curves.ease,
                    switchOutCurve: Curves.ease,
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                              child: child, sizeFactor: animation));
                    },
                    child: widget.isExpanded
                        ? Container(key: UniqueKey())
                        : _buildCollapsedImage(),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              switchInCurve: Curves.ease,
              switchOutCurve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SizeTransition(
                    child: child, sizeFactor: animation, axis: Axis.vertical);
              },
              child: widget.isExpanded ? const Divider() : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
