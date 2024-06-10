import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/views/widgets/main_button.dart';

class SurvellianceScreen extends StatefulWidget {
  static const routeName = 'survelliance-screen';
  const SurvellianceScreen({super.key});

  @override
  State<SurvellianceScreen> createState() => _SurvellianceScreenState();
}

class _SurvellianceScreenState extends State<SurvellianceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const Placeholder(
                fallbackHeight: 250,
              ),
              SizedBox(height: 30.h),
              Text(
                "Survelliance Video",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 20.h),
              const MainButton(text: 'View Full Screen', padding: 40),
              SizedBox(height: 20.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(text: 'Tilt Up', padding: 40),
                  MainButton(text: 'Tilt Down', padding: 40),
                ],
              ),
              SizedBox(height: 20.h),
              const MainButton(text: 'Automatic', padding: 40),
              SizedBox(height: 20.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(text: 'Pan Left', padding: 40),
                  MainButton(text: 'Pan Right', padding: 40),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
