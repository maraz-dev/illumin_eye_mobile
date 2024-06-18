// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/views/features/vm/streetlight-vm/streetlight_cubit.dart';
import 'package:illumin_eye_mobile/views/features/vm/streetlight-vm/streetlight_state.dart';
import 'package:illumin_eye_mobile/views/utils/app_images.dart';
import 'package:illumin_eye_mobile/views/utils/snackbar.dart';
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
        child: BlocConsumer<StreetlightCubit, StreetlightState>(
          listener: (context, state) {
            if (state is StreetlightErrorState) {
              SnackBarDialog.showErrorFlushBarMessage(
                  state.errorMessage, context);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 50.h),
                Image.asset(
                  AppImages.streetlightImage,
                  width: 315,
                ),
                SizedBox(height: 30.h),

                // Title
                Text(
                  "Streetlight Control",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 50.h),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Column(
                    children: [
                      // Turn ON
                      MainButton(
                        isLoading: state is TurnOnLoadingState,
                        text: 'Turn On',
                        padding: 40,
                        onPressed: () async =>
                            await BlocProvider.of<StreetlightCubit>(context)
                                .turnOn(),
                      ),
                      SizedBox(height: 20.h),

                      // Turn OFF
                      MainButton(
                        isLoading: state is TurnOffLoadingState,
                        text: 'Turn Off',
                        padding: 40,
                        onPressed: () async =>
                            await BlocProvider.of<StreetlightCubit>(context)
                                .turnOff(),
                      ),
                      SizedBox(height: 20.h),

                      // Automatic
                      MainButton(
                        isLoading: state is AutomaticLoadingState,
                        text: 'Automatic',
                        padding: 40,
                        onPressed: () async =>
                            await BlocProvider.of<StreetlightCubit>(context)
                                .automatic(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
