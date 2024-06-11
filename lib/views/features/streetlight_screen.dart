import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/views/utils/app_images.dart';
import 'package:illumin_eye_mobile/views/widgets/main_button.dart';

class StreetlightScreen extends StatefulWidget {
  static const routeName = 'streetlight-screen';
  const StreetlightScreen({super.key});

  @override
  State<StreetlightScreen> createState() => _StreetlightScreenState();
}

class _StreetlightScreenState extends State<StreetlightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Image.asset(
              AppImages.streetlightImage,
              width: 315,
            ),
            SizedBox(height: 30.h),
            Text(
              "Streetlight Control",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Column(
                children: [
                  const MainButton(text: 'Turn On', padding: 40),
                  SizedBox(height: 20.h),
                  const MainButton(text: 'Turn Off', padding: 40),
                  SizedBox(height: 20.h),
                  const MainButton(text: 'Automatic', padding: 40),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
