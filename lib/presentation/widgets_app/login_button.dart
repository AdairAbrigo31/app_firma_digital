import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.textButton,
    required this.onPressed
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 8
      ),
      child: ElevatedButton(
          onPressed: this.onPressed,
          child: Text(
            this.textButton,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          )
      ),
    );
  }
}