import 'dart:math';
import 'package:colorful_iconify_flutter/icons/openmoji.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/fluent_emoji_high_contrast.dart';
import 'package:iconify_flutter/icons/ic.dart';


String getRandomIcon(){
  final List<String> icones = [
    Openmoji.pot_of_food,
    Fa6Solid.bowl_food,
    //Fluent.food_egg_20_regular,
    Mdi.food_steak,
    Mdi.food_turkey,
    //Fluent.food_grains_24_regular,
    EmojioneMonotone.pot_of_food,
    Ep.food,
    FluentEmojiHighContrast.pot_of_food,
    //Fluent.food_apple_24_regular,
    Ic.outline_ramen_dining
  ];

  final random = Random();
  return icones[random.nextInt(icones.length)];
}