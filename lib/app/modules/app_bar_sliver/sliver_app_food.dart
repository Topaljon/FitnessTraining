import 'package:flutter/material.dart';
import 'package:get/get.dart';

SliverAppBar funcSliverAppBarFood({textBar, iconBar, context}) => SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          children: [
            Text(
              textBar,
              textScaleFactor: 1,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 24,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFFf4f3ee)
                    : Color(0xFF463f3a),
              ),
              softWrap: false,
            ),
            const SizedBox(
              width: 8,
            ),
            iconBar,
          ],
        ),
      ),
      leading: Builder(
          builder: (BuildContext context) => IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color:Get.theme.primaryColor
                //Color(0xffd57878),
              ),
              onPressed: () {
                Get.back();
              })),
    );
