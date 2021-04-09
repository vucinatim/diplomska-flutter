import 'package:flutter/material.dart';

class RoundedEmailField extends StatelessWidget {
  const RoundedEmailField({
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.errorMessage,
  });

  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Visibility(
          visible: errorMessage != null,
          child: Text(
            errorMessage ?? '',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            onChanged: onChanged,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
