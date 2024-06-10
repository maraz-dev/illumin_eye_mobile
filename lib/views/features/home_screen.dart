import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/views/features/streetlight_screen.dart';
import 'package:illumin_eye_mobile/views/features/survelliance_screen.dart';
import 'package:illumin_eye_mobile/views/utils/app_images.dart';
import 'package:illumin_eye_mobile/views/widgets/main_button.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(height: 120.h),
            Image.asset(
              AppImages.homeImage,
              width: 315,
            ),
            SizedBox(height: 30.h),
            Text(
              "See What's Happening.\nStay in Control",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 50.h),
            MainButton(
              text: 'Streetlight Control',
              onPressed: () =>
                  Navigator.of(context).pushNamed(StreetlightScreen.routeName),
            ),
            SizedBox(height: 20.h),
            MainButton(
              text: 'Surveillance Video',
              onPressed: () =>
                  Navigator.of(context).pushNamed(SurvellianceScreen.routeName),
            ),
          ],
        ),
      )),
    );
  }
}
