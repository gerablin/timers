import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/size_config.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final Function(String) onChanged;

  const CustomTextField(
      {Key? key,
        required this.labelText,
        required this.controller,
        required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
      child: CupertinoTextField(
        onChanged: onChanged,
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 2,
            horizontal: SizeConfig.blockSizeHorizontal * 2),
        controller: controller,
        placeholder: labelText,
        placeholderStyle:
        const TextStyle(color: AppColors.inputPlaceholderColor),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
      ),
    );
  }
}