
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_controller.dart';

class SettingTheme extends StatelessWidget {
  const SettingTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return ListTile(
      leading: const Icon(
        Icons.light,
        size: 32,
      ),
      title: Row(
        children: [
          Obx(
            () => Text(
              themeController.isDarkMode.value ? 'translates.dark_theme'.tr : 'translates.light_theme'.tr,
              //'dark' : 'light',
              maxLines: 5,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
                // color:
                //     themeController.isDarkMode.value
                //         ? AppBarTheme().backgroundColor
                //         : AppThemes().,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Obx(
            () => Switch(
              value: themeController.isDarkMode.value,
              onChanged: (value) {
                themeController.toggleTheme(value);
              },
              // trackColor: WidgetStateProperty.all(
              //   themeController.isDarkMode.value
              //       ? AppBarTheme().backgroundColor
              //       : Colors.white.withValues(alpha: 0.6),
              // ),
              thumbColor: WidgetStateProperty.all(
                  themeController.isDarkMode.value
                      ? AppBarTheme().backgroundColor
                      : Colors.amber),
              activeColor: Colors.transparent,
              activeTrackColor: Colors.black26,
              trackOutlineColor: WidgetStateProperty.all(
                  themeController.isDarkMode.value
                      ? AppBarTheme().backgroundColor
                      : Colors.white.withValues(alpha: 0.6)),
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Icon(
                      Icons.dark_mode_outlined,
                      size: 40,
                      color: Color(0xFFf4f3ee),
                    );
                  }
                  return const Icon(
                    Icons.light_mode,
                    size: 40,
                    color: Colors.amber,
                  ); // other states will use default thumbIcon.
                },
              ),
            ),
          )
        ],
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
