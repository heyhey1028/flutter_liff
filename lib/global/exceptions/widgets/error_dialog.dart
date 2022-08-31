import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

/// Wrapper class for showing ErrorDialog
/// Ref: https://medium.com/flutter-community/how-to-animate-dialogs-in-flutter-here-is-answer-492ea3a7262f
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return nil;
  }

  // Ref: https://qiita.com/kokogento/items/54d6695844edc9415324
  static Future<void> show(BuildContext context, Object e) async {
    final message = e.toString();

    await showGeneralDialog(
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(a1),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      pageBuilder: (context, anim1, anim2) {
        return AlertDialog(
          title: const Icon(
            Icons.error_outline,
            size: 54,
            color: Colors.red,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
