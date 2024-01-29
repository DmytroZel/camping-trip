import 'package:flutter/material.dart';

class BaseDialog extends StatefulWidget {
  final String description;
  final String title;
  final String? positiveText;
  final String? negativeText;
  final VoidCallback? onPositiveTap;
  final VoidCallback? onNegativeTap;
  const BaseDialog(
      {super.key,
      required this.description,
      required this.title,
      this.positiveText,
      this.negativeText,
      this.onPositiveTap,
      this.onNegativeTap});

  @override
  State<BaseDialog> createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.description),
      actions: [
        if (widget.negativeText != null)
          TextButton(
            onPressed: widget.onNegativeTap,
            child: Text(widget.negativeText!),
          ),
        if (widget.positiveText != null)
          TextButton(
            onPressed: widget.onPositiveTap,
            child: Text(widget.positiveText!),
          ),
      ],
    );
  }
}
