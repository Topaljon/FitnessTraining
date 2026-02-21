import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color titleText = Color(0xff2c3d4e);
final Color backGroundColor = Colors.grey.shade200.withValues(alpha: 0.5);

const styleTextAverage = TextStyle(
  color: Colors.white,
  fontFamily: 'Silka',
  fontSize: 14.0,
  decoration: TextDecoration.none,
);

final boxDecorationOnly = BoxDecoration(
  color: const Color(0xffacacac),
  borderRadius: const BorderRadius.only(
    topRight: Radius.circular(12.0),
    bottomRight: Radius.circular(12.0),
  ),
  border: Border.all(width: 2.0, color: const Color(0xffacacac)),
);

BoxDecoration boxDecorationImageBackGrounds(BuildContext context) {
  return BoxDecoration(
    // Image set to background of the body
    image: DecorationImage(
        image: Theme
            .of(context)
            .brightness == Brightness.dark
            ?AssetImage('assets/backgrounds/dark_background_without_title.png')
            :AssetImage('assets/backgrounds/light_background_without_title.png'),
        fit: BoxFit.cover),
  );
}

final boxDecorationCircular = BoxDecoration(
  color: const Color(0xffc9c9c9),
  borderRadius: BorderRadius.circular(12.0),
  border: Border.all(width: 2.0, color: const Color(0xffacacac)),
);

final boxDecorationPlansForToday = BoxDecoration(
  color: backGroundColor,
  borderRadius: BorderRadius.circular(25.0),
  border: Border.all(width: 1.0, color: const Color(0xfffff6f6)),
);

styleText({fontSize}) => TextStyle(
      fontFamily: 'Segoe UI',
      fontSize: fontSize,
      color: const Color(0xffffffff),
);

iconDate() => Container(
    height: 30,
    width: 30,
    decoration: boxDecorationColorBorder(),
    child: Icon(
      Icons.date_range,
      color: Get.theme.brightness==Brightness.dark
        ?Color(0xffd57878)
        :Color(0xFF463f3a),
    )
);

changeIcon() => Icon(
  Icons.edit_note,
  color: Color(0xffacacac),
);

iconDescription(icon) => SizedBox(
  height: 25,
  width: 25,
  child: icon,
);

boxDecorationColorBorder() => BoxDecoration(
  color: Colors.white.withValues(alpha: 0.3),
  borderRadius: BorderRadius.circular(20.0),
);

InputDecoration textFieldDecorationLeft({icon, labelTxt, context}) => InputDecoration(
  prefix: icon,
  //filled: true,
  labelText: labelTxt,
  fillColor: Theme
      .of(context)
      .brightness == Brightness.dark
      ? Color(0xff3a3939).withValues(alpha: 0.9)
      :Colors.white.withValues(alpha: 0.5),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: Theme.of(context).brightness == Brightness.dark
          ? Color(0xffc4dfcc)
          : Color(0xff3e4a40)
    ),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
      bottomLeft: Radius.circular(25),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1.5,
        color: Color(0xffa2a3a2)
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
      bottomLeft: Radius.circular(25),
    ),
  ),
);

InputDecoration textFieldDecorationRight({icon, context, labelTxt}) => InputDecoration(
  prefix: icon,
  labelText: labelTxt,
  fillColor: Theme
      .of(context)
      .brightness == Brightness.dark
      ? Color(0xff3a3939).withValues(alpha: 0.9)
      : Colors.white.withValues(alpha: 0.7),
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
            width: 1.5,
        color: Theme.of(context).brightness == Brightness.dark
            ? Color(0xffc4dfcc)
            : Color(0xff3e4a40)
    ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(15),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: Color(0xffa2a3a2)
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(15),
        ),
      ),
);

InputDecoration formFieldDecoration({lText, icon, context}) => InputDecoration(
    prefix: icon,
    filled: true,
    labelText: lText,
    fillColor: Theme
        .of(context)
        .brightness == Brightness.dark
        ? Color(0xff3a3939).withValues(alpha: 0.9)
        :Colors.white.withValues(alpha: 0.5) ,
    //labelStyle: const TextStyle(color: Color(0xffd57878)),
    // Set border for enabled state (default)
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.5,
          color: Color(0xffa2a3a2)
      ),
      borderRadius: BorderRadius.circular(25),
    ),
    // Set border for focused state
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5,
         color: Theme.of(context).brightness == Brightness.dark
             ? Color(0xffc4dfcc)
             : Color(0xff3e4a40)
      ),
      borderRadius: BorderRadius.circular(25),
    )
);


final List<Color> setOfExercisesColor = [
  Colors.black12,
  Color(0xffE9D0BA),
  Colors.lightBlueAccent.shade100,
  Color(0xffFFE0CE).withValues(alpha: 0.5),
  Colors.blueAccent.shade100.withValues(alpha: 0.5),
  Colors.black26,
  Colors.lightBlueAccent.withValues(alpha: 0.5),
  Color(0xffD0CFB3),
  Color(0xffC0E4E4),
  Color(0xffF6DCCF),
];

Color colorSetOfExercises(int setExercises) {
  Color colorExercises = Colors.amber.withValues(alpha: 0.5);

  switch (setExercises) {
    case 1:
      colorExercises = setOfExercisesColor[1];
      break;
    case 2:
      colorExercises = setOfExercisesColor[2];
      break;
    case 3:
      colorExercises = setOfExercisesColor[3];
      break;
    case 4:
      colorExercises = setOfExercisesColor[4];
      break;
    case 5:
      colorExercises = setOfExercisesColor[5];
      break;
    case 6:
      colorExercises = setOfExercisesColor[6];
      break;
    case 7:
      colorExercises = setOfExercisesColor[7];
      break;
    case 8:
      colorExercises = setOfExercisesColor[8];
      break;
    case 9:
      colorExercises = setOfExercisesColor[9];
      break;
    case 10:
      colorExercises = setOfExercisesColor[10];
      break;
    default:
      colorExercises;
  }
  return colorExercises;
}