import 'package:flutter/cupertino.dart';
import 'package:timers/utils/size_config.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 2,
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
      ),
    );
  }
}

class BottomSheetSubtitle extends StatelessWidget {
  const BottomSheetSubtitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
    );
  }
}
