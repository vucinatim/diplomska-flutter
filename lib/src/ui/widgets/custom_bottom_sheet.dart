import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: horizontalAppPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          verticalSpaceModerate,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 50,
              height: 2.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          verticalSpaceMedium,
          child ?? const Center(child: Text('No Content')),
        ],
      ),
    );
  }
}
