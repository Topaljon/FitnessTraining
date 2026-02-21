import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import '../../constants/style_widget.dart' show backGroundColor;
import '../strength_indicators/view_strength_indicators/view_strength_indicators.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
              width: Get.width / 2,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0x83818a87)
                    : backGroundColor,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(width: 2.0, color: const Color(0x83bcc5c5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Iconify(GameIcons.weight_lifting_up,
                        size: 30,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? backGroundColor
                            : Color(0x83818a87),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('translates.your_progress'.tr,
                        //'Your progress',
                        style: TextStyle(
                            //color: Color(0xff46525e),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        softWrap: false,
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Image(
                          //   color: Theme.of(context).brightness == Brightness.dark
                          //       ? Color(0xffc4dfcc)
                          //       : Color(0xff202722),
                          //     height: 80,
                          //     image:
                          //     //controllerProfile.menOrWomen.value
                          //     //     ? AssetImage(
                          //     //     'assets/images/fitness_female.png')
                          //     //     :
                          //     AssetImage(
                          //         'assets/images/block_pull.png')
                          // ),
                          Image(
                              height: 80,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Color(0xffc4dfcc)
                                  : Color(0xff202722),
                              image:
                          //controllerProfile.menOrWomen.value
                          //     ? AssetImage(
                          //     'assets/images/fitness_female.png')
                          //     :
                          AssetImage(
                                 'assets/images/lifting_the_bar.png')
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        child: Text('translates.your_achievements_in_the_gym'.tr,
                          //"your achievements in the gym",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              //color: titleText,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
      onTap: () {
        Get.to(() => ViewStrengthIndicators());
      },
    );
  }
}