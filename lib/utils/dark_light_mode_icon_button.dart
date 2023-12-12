import 'package:ecommerce_app/providers/settings.dart';
import 'package:flutter/material.dart';

class DarkLightModeIconButton extends StatelessWidget {
  const DarkLightModeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (darkMode.value == null) {
          darkMode.value =
              !(MediaQuery.of(context).platformBrightness == Brightness.dark);
        } else {
          if (MediaQuery.of(context).platformBrightness ==
              (darkMode.value! ? Brightness.dark : Brightness.light)) {
            darkMode.value = null;
          } else {
            darkMode.value = !darkMode.value!;
          }
        }
      },
      icon: ValueListenableBuilder(
        valueListenable: darkMode,
        builder: (context, value, child) => Icon(
          darkMode.value == null
              ? Icons.brightness_auto_rounded
              : darkMode.value!
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
        ),
      ),
    );
  }
}
