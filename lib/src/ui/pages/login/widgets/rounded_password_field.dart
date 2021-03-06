import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({
    this.hintText,
    this.onChanged,
    this.errorMessage,
  });

  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String? errorMessage;

  @override
  State<StatefulWidget> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Visibility(
          visible: widget.errorMessage != null,
          child: Text(
            widget.errorMessage ?? '',
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
            obscureText: _isObscured,
            onChanged: widget.onChanged,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: widget.hintText,
              icon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 0,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: _isObscured
                    ? Icon(
                        Icons.visibility,
                        color: Theme.of(context).primaryColor,
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                      ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
