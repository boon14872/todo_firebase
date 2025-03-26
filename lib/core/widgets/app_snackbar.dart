import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { error, success }

void showSnackBar({
  required String title,
  required String message,
  SnackbarType type = SnackbarType.success,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: type == SnackbarType.error ? Colors.red : Colors.green,
    colorText: Colors.white,
    duration:
        type == SnackbarType.error
            ? const Duration(seconds: 3)
            : const Duration(seconds: 1),
  );
}
