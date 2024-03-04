import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.text, required this.callback});

  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(SizeConfig.blockSizeVertical * 8),
      ),
      child: Text(text),
    );
  }
}