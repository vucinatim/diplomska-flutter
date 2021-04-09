import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

class OptionsMenu extends StatefulWidget {
  final List<MenuOption> options;
  final Color backgroundColor;
  final Color? buttonBackgroundColor;

  const OptionsMenu({
    Key? key,
    required this.options,
    this.backgroundColor = Colors.white,
    this.buttonBackgroundColor = Colors.white,
  }) : super(key: key);
  @override
  _OptionsMenuState createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey? _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> animation;

  static final Tween<double> _borderRadiusTween =
      Tween<double>(begin: 100, end: 6);
  static final Tween<double> _scaleTween = Tween<double>(begin: 0.5, end: 1);
  static final Tween<double> _opacityTween = Tween<double>(begin: 0, end: 1);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 100),
    );
    animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeOut)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
        } else if (status == AnimationStatus.dismissed) {
          _overlayEntry.remove();
        }
      });
    _key = LabeledGlobalKey('button');
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void findButton() {
    final RenderBox renderBox =
        _key!.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    _animationController.forward();
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: CustomIconButton(
        icon: const Icon(Icons.more_vert),
        backgroundColor: widget.buttonBackgroundColor,
        onPressed: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (_) {
                  closeMenu();
                },
              ),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  top: buttonPosition.dy + buttonSize.height / 2,
                  right: buttonSize.width / 2 + 10,
                  child: Transform.scale(
                    scale: _scaleTween.evaluate(animation),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          max(4, _borderRadiusTween.evaluate(animation))),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: _opacityTween.evaluate(animation) * 7,
                          sigmaY: _opacityTween.evaluate(animation) * 7,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: widget.backgroundColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(max(
                                  4, _borderRadiusTween.evaluate(animation))),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: List<Widget>.generate(
                                  widget.options.length, (int index) {
                                return MaterialButton(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  height: 0,
                                  minWidth: 0,
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    widget.options[index].onPressed!();
                                    closeMenu();
                                  },
                                  child: Container(
                                    width: Size.infinite.width,
                                    padding: const EdgeInsets.all(10),
                                    child: widget.options[index].child,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class MenuOption {
  MenuOption({this.child, this.onPressed});

  final Widget? child;
  final void Function()? onPressed;
}
