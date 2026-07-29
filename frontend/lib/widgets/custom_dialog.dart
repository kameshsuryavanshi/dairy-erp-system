import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmText;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Save',
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(child: content),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}
