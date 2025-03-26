import 'package:flutter/material.dart';
import 'package:todo_firebase/core/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool? disabled;
  final Color? color;

  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.disabled = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled! ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      child: AppText(
        text,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
