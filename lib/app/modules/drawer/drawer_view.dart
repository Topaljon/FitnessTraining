import 'package:FitnTrain/app/modules/drawer/setting_theme/setting_theme.dart' show SettingTheme;
import 'package:FitnTrain/app/modules/drawer/settings_profile/controller_settings_profile/controller_profile.dart' show ProfileController;
import 'package:FitnTrain/app/modules/drawer/settings_profile/controller_settings_profile/input_view.dart' show InputView;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/style_widget.dart';
import 'package:flag/flag.dart';

class DrawerView extends StatelessWidget {
  DrawerView({
    super.key,
  });

  final controllerProfile = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    String inputName = controllerProfile.getName.toString();
    String inputLastName = controllerProfile.getLastName.toString();
    String inputPathToImage = controllerProfile.getImagePath.toString();
    String? locales = Get.deviceLocale!.countryCode;

    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? titleText.withValues(alpha: 0.8)
          : Color(0xffc9c9c9),
      surfaceTintColor: Colors.transparent,
      child: ListView(
        children: [
          _drawerHeader(
              inputNameHeader: inputName,
              inputLastNameHeader: inputLastName,
              pathToImage: inputPathToImage), // DrawerHeader
          SettingTheme(),
          ListTile(
            leading: const Icon(
              Icons.flag,
              //color: Color(0xff020202),
              size: 32,
            ),
            title: Row(
              children: [
                Text('translates.language'.tr,
                  //'Language',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 18,
                    //color: Color(0xff020202),
                  ),
                  softWrap: false,
                ),
                const Expanded(child: SizedBox()),
                Flag.fromString(
                  locales ?? 'EN',
                  height: 20,
                  width: 30,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 32,
            ),
            title: Text('translates.settings'.tr,
              //'Settings',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
              ),
              softWrap: false,
            ),
            onTap: () {
              Get.to(() => InputView());
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              size: 32,
            ),
            title: Text("translates.logout".tr,
              //'LogOut',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
                //color: Color(0xff020202),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Container(
          //   child: SvgPicture.string(
          //     _svg_im2qeq,
          //     allowDrawingOutsideViewBox: true,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          // Container(
          //   child: SvgPicture.string(
          //     _svg_jpilra,
          //     allowDrawingOutsideViewBox: true,
          //     fit: BoxFit.fill,
          //   ),
          // ),

          // Container(
          //   child: SvgPicture.string(
          //     _svg_jimdih,
          //     allowDrawingOutsideViewBox: true,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          // Container(
          //   child: SvgPicture.string(
          //     _svg_as73gn,
          //     allowDrawingOutsideViewBox: true,
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ],
      ),
    );

    //       Positioned(
    //         bottom: 4.0,
    //         child: const Text(
    //           'Development\nand design',
    //           style: TextStyle(
    //             fontFamily: 'Segoe UI',
    //             fontSize: 20,
    //             color: Color(0xffffffff),
    //           ),
    //           softWrap: false,
    //         ),
    //       ),
    //
    //       //иконка выход
    //       Positioned(
    //         bottom: 4.0,
    //         child: Stack(
    //           children: <Widget>[
    //             Align(
    //               alignment: const Alignment(-0.503, 0.0),
    //               child: SizedBox(
    //                 width: 7.0,
    //                 height: 14.0,
    //                 child: SvgPicture.string(
    //                   _svg_jimdih,
    //                   allowDrawingOutsideViewBox: true,
    //                 ),
    //               ),
    //             ),
    //             Align(
    //               alignment: const Alignment(-0.25, 0.021),
    //               child: SizedBox(
    //                 width: 21.0,
    //                 height: 1.0,
    //                 child: SvgPicture.string(
    //                   _svg_as73gn,
    //                   allowDrawingOutsideViewBox: true,
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               bottom: 4.0,
    //               child: SvgPicture.string(
    //                 _svg_y41w,
    //                 allowDrawingOutsideViewBox: true,
    //                 fit: BoxFit.fill,
    //               ),
    //             ),
    //             SizedBox.expand(
    //                 child: SvgPicture.string(
    //               _svg_uata1o,
    //               allowDrawingOutsideViewBox: true,
    //               fit: BoxFit.fill,
    //             )),
    //           ],
    //         ),
    //       ),
    //
    //       Positioned(
    //         bottom: 5.0,
    //         child:
    //             // Adobe XD layer: 'chevron right' (group)
    //             Stack(
    //           children: <Widget>[
    //             Positioned(
    //               bottom: 6.0,
    //               child: const Icon(
    //                 Icons.arrow_forward_ios_rounded,
    //                 color: Colors.white,
    //                 size: 38,
    //               ),
    //             ),
    //             SizedBox.expand(
    //                 child: SvgPicture.string(
    //               _svg_atqkbo,
    //               allowDrawingOutsideViewBox: true,
    //               fit: BoxFit.fill,
    //             )),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  DrawerHeader _drawerHeader(
          {inputNameHeader, inputLastNameHeader, pathToImage}) =>
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          accountName: Text(
            '$inputNameHeader $inputLastNameHeader',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 28,
              //color: Color(0xff131313),
            ),
            softWrap: false,
          ),
          // accountEmail: const Text("yuoremail@gmail.com",
          //     style: TextStyle(
          //       fontFamily: 'Segoe UI',
          //       fontSize: 12,
          //       color: Color(0xff020202),
          //     )),
          currentAccountPictureSize: const Size.square(50),
          currentAccountPicture: ClipOval(
            child: Image(
              image: AssetImage(pathToImage), //нужно будет заменить переменной
              fit: BoxFit.cover,
            ),
          ),
          accountEmail: null, // CircleAvatar
        ), // UserAccountDrawerHeader
      );
}

const String _svg_im2qeq =
    '<svg viewBox="0.0 676.6 270.8 238.4" ><path transform="translate(-238.92, 372.22)" d="M 352.1136474609375 315.705078125 C 366.2786254882812 316.614990234375 380.9100341796875 303.819091796875 393.70751953125 310.0679626464844 C 406.4194946289062 316.2750854492188 402.63427734375 339.81689453125 415.125244140625 346.4729309082031 C 444.1345825195312 361.9312133789062 499.1453247070312 339.5277404785156 508.7811889648438 371.3874816894531 C 517.4642944335938 400.0971069335938 463.5170288085938 408.03662109375 438.6207275390625 424.1578674316406 C 425.7977905273438 432.4611511230469 409.4285888671875 433.2989196777344 397.795654296875 443.2544555664062 C 386.6057739257812 452.8307800292969 383.098388671875 468.3887023925781 373.6588745117188 479.7525024414062 C 355.138671875 502.0481262207031 343.7806396484375 538.346435546875 315.386962890625 542.4625244140625 C 291.4903869628906 545.9267578125 264.6933898925781 520.3539428710938 260.3841552734375 496.1735534667969 C 255.1280822753906 466.6801452636719 297.2571716308594 443.3642272949219 292.4560546875 413.7905578613281 C 288.9904479980469 392.4429321289062 248.8968505859375 397.1288146972656 241.0411071777344 377.0241088867188 C 234.2413482666016 359.6218872070312 244.8949127197266 337.9136352539062 257.4648132324219 324.2394714355469 C 269.90087890625 310.7109375 289.5423278808594 306.1758422851562 307.6707153320312 304.5412292480469 C 323.0938415527344 303.1505432128906 336.6608581542969 314.7124328613281 352.1136474609375 315.705078125" fill="#deaaaa" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jpilra =
    '<svg viewBox="-43.4 630.1 230.8 284.9" ><path transform="translate(-368.94, 406.89)" d="M 408.0894775390625 223.4529724121094 C 428.578857421875 221.3221893310547 453.0509033203125 231.8076629638672 463.4208068847656 251.5508117675781 C 474.9947204589844 273.5863037109375 448.0646667480469 307.0841064453125 462.4580688476562 326.9647827148438 C 478.6768493652344 349.3667602539062 517.8115844726562 330.694091796875 535.734130859375 351.4326782226562 C 552.3409423828125 370.6488647460938 564.0318603515625 406.7420654296875 550.2225341796875 428.51904296875 C 534.731689453125 452.947509765625 495.7381591796875 434.0030212402344 473.1182250976562 450.1759948730469 C 455.412109375 462.835693359375 459.96875 510.3959655761719 439.0194702148438 508.0279846191406 C 413.2847290039062 505.1190795898438 416.21142578125 451.2182312011719 392.0313720703125 441.0104064941406 C 372.2455444335938 432.6575927734375 350.0872802734375 476.5778198242188 332.7128295898438 463.1495361328125 C 316.5196533203125 450.6341552734375 332.1945495605469 419.7769775390625 337.0963745117188 398.5523071289062 C 340.3159484863281 384.611572265625 354.68212890625 375.9420776367188 356.1555786132812 361.6433715820312 C 357.6453857421875 347.1854858398438 344.8880920410156 334.9432373046875 345.1502075195312 320.3939208984375 C 345.5133056640625 300.2410278320312 347.32666015625 278.8693542480469 357.9414672851562 262.5201110839844 C 370.0600891113281 243.8546295166016 387.4609069824219 225.5982360839844 408.0894775390625 223.4529724121094" fill="#deaaaa" fill-opacity="0.49" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jimdih =
    '<svg viewBox="10.3 17.1 6.6 13.7" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 41.14, 6.86)" d="M 24.21999931335449 -24 L 30.86000061035156 -17.13999938964844 L 24.21999931335449 -10.28999996185303" fill="#000000" fill-opacity="0.0" stroke="#fffefe" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_as73gn =
    '<svg viewBox="10.3 24.0 20.6 1.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 41.14, 6.86)" d="M 30.86000061035156 -17.13999938964844 L 10.28999996185303 -17.13999938964844" fill="#000000" fill-opacity="0.0" stroke="#fffefe" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_y41w =
    '<svg viewBox="17.1 8.0 22.9 32.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 41.14, 6.86)" d="M 24 -1.139999985694885 L 5.710000038146973 -1.149999976158142 C 3.190000057220459 -1.149999976158142 1.139999985694885 -3.200000047683716 1.139999985694885 -5.71999979019165 L 1.139999985694885 -28.56999969482422 C 1.139999985694885 -31.09000015258789 3.190000057220459 -33.13999938964844 5.710000038146973 -33.13999938964844 L 24 -33.13999938964844" fill="#000000" fill-opacity="0.0" stroke="#fffefe" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_uata1o =
    '<svg viewBox="0.0 0.0 48.0 48.0" ><path  d="M 0 0 L 48 0 L 48 48 L 0 48 L 0 0 Z" fill="#000000" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_atqkbo =
    '<svg viewBox="0.0 0.0 48.0 48.0" ><path  d="M 0 0 L 48 0 L 48 48 L 0 48 L 0 0 Z" fill="#ffffff" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
