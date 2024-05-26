
import 'package:flutter/widgets.dart';

class TextFieldHintOverlay extends StatelessWidget {
  const TextFieldHintOverlay({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IgnorePointer(child: Text(text)),
        ),),);
  }
}