import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/views/features/home_screen.dart';
import 'package:illumin_eye_mobile/views/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150.h),
              Image.asset(
                AppImages.splashImageOne,
                width: 65,
              ),
              SizedBox(height: 10.h),
              Text(
                'IlluminEye',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 50.h),
              Image.asset(
                AppImages.splashImageTwo,
                width: 240,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
