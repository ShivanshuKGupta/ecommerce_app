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
              (darkMode.value == true ? Brightness.dark : Brightness.light)) {
            darkMode.value == null;
          }
          darkMode.value = !darkMode.value!;
        }
      },
      icon: Icon(
        darkMode.value == null
            ? Icons.brightness_auto_rounded
            : !darkMode.value!
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
      ),
    );
  }
}
