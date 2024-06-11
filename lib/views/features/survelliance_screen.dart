import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              SizedBox(height: 40.h),
              Text(
                "Survelliance Video",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 20.h),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: MainButton(text: 'View Full Screen'),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: MainButton(text: 'Tilt Up')),
                        SizedBox(width: 30.w),
                        const Expanded(child: MainButton(text: 'Tilt Down')),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: MainButton(text: 'Center'),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: MainButton(text: 'Pan Left')),
                        SizedBox(width: 30.w),
                        const Expanded(child: MainButton(text: 'Pan Right')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
