import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/maki.dart';
import '../../constants/style_widget.dart';

SliverAppBar funcSliverAppBar({textBar, context}) => SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          children: [
            Text(
              textBar,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 24,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? backGroundColor
                    : Color(0x83333937),
              ),
              softWrap: false,
            ),
            const SizedBox(
              width: 8,
            ),
            Transform.rotate(
              angle: 2.29,
              child: Iconify(
                Maki.fitness_centre_11,
                size: 30,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? backGroundColor
                    : Color(0x83333937),
              )
            ),
          ],
        ),
      ),
      leading: Builder(
          builder: (BuildContext context) => IconButton(
              icon:Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? backGroundColor
                    : Color(0x83333937),
              ),
              onPressed: () {
                Get.back();
              })),
    );
