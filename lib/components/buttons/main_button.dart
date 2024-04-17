import 'package:flutter/material.dart';
import '../../utils/size_config.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key, required this.text, required this.callback, required this.isEnabled});

  final String text;
  final VoidCallback callback;
  final isEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? callback : null,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(SizeConfig.blockSizeVertical * 8),
      ),
      child: Text(text),
    );
  }
}