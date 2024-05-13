
import 'package:flutter/material.dart';
import 'package:timers/components/icons/sessions_cooldown_icon.dart';
import 'package:timers/components/icons/sessions_icon.dart';
import 'package:timers/components/text_fields/custom_text_field.dart';
import 'package:timers/utils/size_config.dart';
import 'package:timers/utils/strings.dart' as Strings;

class SessionInputs extends StatelessWidget {
  const SessionInputs({super.key,
    required this.sessionTextEditingController,
    required this.sessionCooldownTextEditingController,
    required this.onChanged});

  final TextEditingController sessionTextEditingController;
  final TextEditingController sessionCooldownTextEditingController;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right:8.0),
                child: SessionsIcon(),
              ),
              Flexible(
                child: CustomTextField(
                  labelText: Strings.sessionPlaceholder,
                  controller: sessionTextEditingController,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: SessionsCooldownIcon(),
            ),
            Flexible(
              child: CustomTextField(
                labelText: Strings.sessionCooldownPlaceholder,
                controller: sessionCooldownTextEditingController,
                onChanged: onChanged,
              ),
            ),
          ],
        )
      ],
    );
  }
}