import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showCompletedSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(width: 8.0),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            SizedBox(width: 8.0),
            Text(message),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
