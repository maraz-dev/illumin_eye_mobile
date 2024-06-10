import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/views/theme/app_colors.dart';

ThemeData themeData() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.kSecondaryColor,
    fontFamily: 'Inter',
    textTheme: textTheme(),
    //inputDecorationTheme: inputDecorationTheme(),
  );
}

// InputDecorationTheme inputDecorationTheme() {
//   OutlineInputBorder focusInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8),
//     borderSide: const BorderSide(color: AppColors.kSecondaryColorTwo, width: 1),
//   );
//   OutlineInputBorder defaultInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8),
//     borderSide: const BorderSide(color: AppColors.kGrey300, width: 1),
//   );
//   OutlineInputBorder errorInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8),
//     borderSide: const BorderSide(color: AppColors.kErrorColor, width: 1),
//   );
//   return InputDecorationTheme(
//     contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
//     enabledBorder: defaultInputBorder,
//     focusedBorder: focusInputBorder,
//     errorBorder: errorInputBorder,
//     border: defaultInputBorder,
//     fillColor: AppColors.kWhiteColor,
//     filled: true,
//     suffixIconColor: AppColors.kInactiveColor,
//   );
// }

// PinTheme defaultPinInputTheme = PinTheme(
//   width: 50.w,
//   height: 55.h,
//   textStyle: textTheme.call().displayMedium,
//   decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(12.r),
//       color: AppColors.kGrey50,
//       border: Border.all(color: AppColors.kSecondaryColorTwo)),
// );

// PinTheme focusedPinInputTheme = PinTheme(
//   width: 50.w,
//   height: 55.h,
//   textStyle: textTheme.call().displayMedium,
//   decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(12.r),
//       color: AppColors.kPinInputColor,
//       border: Border.all(color: AppColors.kPrimaryColor)),
// );

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 34.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: AppColors.kTextTitleColor,
    ),
    displayMedium: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
      color: AppColors.kTextTitleColor,
    ),
    displaySmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: AppColors.kTextTitleColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      color: AppColors.kWhite,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      color: AppColors.kWhite,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      color: AppColors.kWhite,
    ),
  );
}

// AppBarTheme appBarTheme() {
//   return const AppBarTheme(
//     centerTitle: true,
//     elevation: 0,
//     color: Colors.transparent,
//     iconTheme: IconThemeData(
//       color: kWhiteColor,
//     ),
//   );