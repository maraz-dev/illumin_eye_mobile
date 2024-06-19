import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/views/features/home_screen.dart';
import 'package:illumin_eye_mobile/views/features/splash_screen.dart';
import 'package:illumin_eye_mobile/views/features/streetlight_screen.dart';
import 'package:illumin_eye_mobile/views/features/survelliance_screen.dart';
import 'package:illumin_eye_mobile/views/features/vm/streetlight-vm/streetlight_cubit.dart';
import 'package:illumin_eye_mobile/views/features/vm/survelliance-vm/survelliance_cubit.dart';
import 'package:illumin_eye_mobile/views/theme/app_theme.dart';

// Replace with IP Address of the ESP32
const String esp32Url = 'http://172.16.16.40';
const String streamUrl = "$esp32Url/stream.mp4";
const String testUrl =
    "https://cdn.pixabay.com/video/2022/09/05/130274-746686710_large.mp4";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SurvellianceCubit>(create: (_) => SurvellianceCubit()),
        BlocProvider<StreetlightCubit>(create: (_) => StreetlightCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            theme: themeData(),
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              StreetlightScreen.routeName: (context) =>
                  const StreetlightScreen(),
              SurvellianceScreen.routeName: (context) =>
                  const SurvellianceScreen(),
            },
          );
        },
      ),
    );
  }
}
