import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key, this.icon, this.onPressed, this.backgroundColor})
      : super(key: key);

  final Widget? icon;
  final void Function()? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      color: backgroundColor ?? Colors.white70,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      padding: EdgeInsets.zero,
      textColor: Colors.black87,
      visualDensity: const VisualDensity(horizontal: 1, vertical: 1),
      child: icon ?? Icon(Icons.do_not_disturb_alt),
      shape: const CircleBorder(),
    );
  }
}
