import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Класс, содержащий определения ThemeData для светлой и темной тем.
/// Использует современный подход с ColorScheme для согласованности.
class AppThemes {
  // --- Цветовая палитра для Светлой темы ---
  // Основные цвета
  static const Color _lightPrimaryColor = Color(0xFFbcb8b1);
  static const Color _lightSecondaryColor = Color(0xFF8a817c);
  static const Color _lightBackgroundColor = Color(0xFFf4f3ee);
  static const Color _lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color _lightErrorColor = Color(0xff723d46);

  // Цвета "на" (для текста и иконок, расположенных на основных цветах)
  static const Color _lightOnPrimaryColor =
      Color(0xFFFFFFFF); // Белый текст на основном цвете
  static const Color _lightOnSecondaryColor =
      Color(0xFF000000); // Черный текст на дополнительном цвете
  static const Color _lightOnBackgroundColor = Color(
      0xFF212121); // Очень темный серый для основного текста на фоне/поверхности
  static const Color _lightOnBackgroundSecondaryColor =
  Color(0xFF8a817c); // Средний серый для второстепенного текста
  static const Color _lightOnBackgroundDisabledColor =
  Color(0xFFbcb8b1); // Светло-серый для отключенных элементов
  static const Color _lightDividerColor =
      Color(0xFFEEEEEE); // Очень светло-серый для разделителей

  // --- Цветовая палитра для Темной темы ---
  // Основные цвета
  static const Color _darkPrimaryColor = Color(0xFF463f3a);
  static const Color _darkSecondaryColor =
  Color(0xFFbcb8b1); // Бирюзовый (остается таким же)
  static const Color _darkBackgroundColor =
      Color(0xFF121212); // Очень темный серый фон
  static const Color _darkSurfaceColor =
      Color(0xFF1E1E1E); // Темно-серый для поверхности
  static const Color _darkErrorColor =
      Color(0xFFCF6679); // Светло-красный для ошибок

  // Цвета "на" (для текста и иконок, расположенных на основных цветах)
  static const Color _darkOnPrimaryColor =
      Color(0xFF000000); // Черный текст на основном цвете
  static const Color _darkOnSecondaryColor =
      Color(0xFF000000); // Черный текст на дополнительном цвете
  static const Color _darkOnBackgroundColor =
      Color(0xFFFFFFFF); // Белый для основного текста на фоне/поверхности
  static const Color _darkOnBackgroundSecondaryColor =
      Color(0xFFBDBDBD); // Светло-серый для второстепенного текста
  static const Color _darkOnBackgroundDisabledColor =
      Color(0xFF757575); // Средний серый для отключенных элементов
  static const Color _darkDividerColor =
      Color(0xFF424242); // Темно-серый для разделителей

  /// **Определение Светлой темы (ThemeData)**
  /// Настраивает все основные цвета и стили виджетов для светлого режима.
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, // Указываем, что это светлая тема
    primaryColor: _lightPrimaryColor, // Устанавливаем основной цвет

    // ColorScheme - современный способ определения палитры
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      surface: _lightSurfaceColor,
      background: _lightBackgroundColor,
      error: _lightErrorColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: _lightOnSecondaryColor,
      onSurface: _lightOnBackgroundColor, // Текст/иконки на поверхности
      onBackground: _lightOnBackgroundColor, // Текст/иконки на фоне
      onError: _lightOnPrimaryColor, // Текст/иконки на цвете ошибки
      brightness: Brightness.light,
    ),

    useMaterial3: true,
    fontFamily: GoogleFonts.roboto().fontFamily,

    scaffoldBackgroundColor: _lightBackgroundColor, // Цвет фона для Scaffold
    cardColor: _lightSurfaceColor, // Цвет фона для Card
    dividerColor: _lightDividerColor, // Цвет для разделителей

    // TextTheme - настройка стилей текста по всему приложению
    textTheme: TextTheme(
      // Заголовки
      headlineLarge: TextStyle(color: _lightOnBackgroundColor),
      headlineMedium: TextStyle(color: _lightOnBackgroundColor),
      headlineSmall: TextStyle(color: _lightOnBackgroundColor),
      // Заголовки разделов/подзаголовки
      titleLarge: TextStyle(color: _lightOnBackgroundColor),
      titleMedium: TextStyle(color: _lightOnBackgroundColor),
      titleSmall: TextStyle(color: _lightOnBackgroundColor),
      // Основной текст
      bodyLarge: TextStyle(color: _lightOnBackgroundColor),
      bodyMedium: TextStyle(color: _lightOnBackgroundColor),
      bodySmall: TextStyle(
          color:
              _lightOnBackgroundSecondaryColor), //Второстепенный/мелкий текст
      // Текст кнопок и меток
      labelLarge:
          TextStyle(color: _lightOnPrimaryColor), //Текст для ElevatedButton
      labelMedium: TextStyle(
          color: _lightOnBackgroundDisabledColor), //Отключенный текст
      labelSmall: TextStyle(color: _lightOnBackgroundSecondaryColor),
    ),

    // AppBarTheme - настройка внешнего вида AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightPrimaryColor, // Фон AppBar
      foregroundColor: _lightOnPrimaryColor, // Цвет текста и иконок в AppBar
      elevation: 4.0, // Небольшая тень для AppBar
      centerTitle: true, // Центрирование заголовка
    ),

    // ElevatedButtonTheme - настройка стилей для ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _lightOnPrimaryColor, // Цвет текста на кнопке
        backgroundColor: _lightPrimaryColor, // Цвет фона кнопки
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)), // Скругленные углы
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Отступы
      ),
    ),

    // TextButtonTheme - настройка стилей для TextButton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightPrimaryColor, // Цвет текста кнопки
      ),
    ),

    // FloatingActionButtonTheme - настройка стилей для FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightSecondaryColor, // Фон FAB
      foregroundColor: _lightOnSecondaryColor, // Цвет иконки на FAB
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(16.0))), // Скругленные углы
    ),

    // Input Decoration Theme - для полей ввода
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: _lightDividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: _lightDividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: _lightPrimaryColor, width: 2.0),
      ),
      labelStyle: TextStyle(color: _lightOnBackgroundSecondaryColor),
      hintStyle: TextStyle(color: _lightOnBackgroundDisabledColor),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: _lightSurfaceColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.all(8.0),
    ),
  );

  /// **Определение Темной темы (ThemeData)**
  /// Настраивает все основные цвета и стили виджетов для темного режима.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // Указываем, что это темная тема
    primaryColor: _darkPrimaryColor, // Устанавливаем основной цвет

    useMaterial3: true,
    fontFamily: GoogleFonts.roboto().fontFamily,

    // ColorScheme для темной темы
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      surface: _darkSurfaceColor,
      background: _darkBackgroundColor,
      error: _darkErrorColor,
      onPrimary: _darkOnPrimaryColor,
      onSecondary: _darkOnSecondaryColor,
      onSurface: _darkOnBackgroundColor,
      onBackground: _darkOnBackgroundColor,
      onError: _darkOnPrimaryColor,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: _darkBackgroundColor,
    cardColor: _darkSurfaceColor,
    dividerColor: _darkDividerColor,

    // TextTheme для темной темы
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: _darkOnBackgroundColor),
      headlineMedium: TextStyle(color: _darkOnBackgroundColor),
      headlineSmall: TextStyle(color: _darkOnBackgroundColor),
      titleLarge: TextStyle(color: _darkOnBackgroundColor),
      titleMedium: TextStyle(color: _darkOnBackgroundColor),
      titleSmall: TextStyle(color: _darkOnBackgroundColor),
      bodyLarge: TextStyle(color: _darkOnBackgroundColor),
      bodyMedium: TextStyle(color: _darkOnBackgroundColor),
      bodySmall: TextStyle(color: _darkOnBackgroundSecondaryColor),
      labelLarge: TextStyle(color: _darkOnPrimaryColor),
      labelMedium: TextStyle(color: _darkOnBackgroundDisabledColor),
      labelSmall: TextStyle(color: _darkOnBackgroundSecondaryColor),
    ),

    // AppBarTheme для темной темы
    appBarTheme: const AppBarTheme(
      backgroundColor:
          _darkBackgroundColor, // AppBar может быть цвета фона в темной теме
      foregroundColor: _darkOnBackgroundColor,
      elevation: 0.0, // В темной теме тени менее выражены
      centerTitle: true,
    ),

    // ElevatedButtonTheme для темной темы
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _darkOnPrimaryColor,
        backgroundColor: _darkPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    // TextButtonTheme для темной темы
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _darkPrimaryColor,
      ),
    ),

    // FloatingActionButtonTheme для темной темы
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkSecondaryColor,
      foregroundColor: _darkOnSecondaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
    ),

    // Input Decoration Theme для темной темы
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: _darkDividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: _darkDividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: _darkPrimaryColor, width: 3.0),
      ),
      labelStyle: TextStyle(color: _darkOnBackgroundSecondaryColor),
      hintStyle: TextStyle(color: _darkOnBackgroundDisabledColor),
    ),

    // Card Theme для темной темы
    cardTheme: CardThemeData(
      color: _darkSurfaceColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.all(8.0),
    ),
  );
}
