import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.text,
    this.onPressed,
    this.color = Colors.black,
    this.textColor = Colors.white,
  });

  final String? text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: size.width * 0.8,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 40,
            ),
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.all(Colors.white24),
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onPressed,
        child: Text(
          text ?? noValueString,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
