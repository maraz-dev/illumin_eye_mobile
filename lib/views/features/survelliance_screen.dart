import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/main.dart';
import 'package:illumin_eye_mobile/views/features/vm/survelliance-vm/survelliance_cubit.dart';
import 'package:illumin_eye_mobile/views/features/vm/survelliance-vm/survelliance_state.dart';
import 'package:illumin_eye_mobile/views/utils/snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:illumin_eye_mobile/views/widgets/main_button.dart';

class SurvellianceScreen extends StatefulWidget {
  static const routeName = 'survelliance-screen';
  const SurvellianceScreen({super.key});

  @override
  State<SurvellianceScreen> createState() => _SurvellianceScreenState();
}

class _SurvellianceScreenState extends State<SurvellianceScreen> {
  // Controller for the Video
  //late CachedVideoPlayerController _playerController;
  //late VideoPlayerController _controller;
  late WebViewController _webViewController;
  //late CustomVideoPlayerController _customController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  void initializeVideoPlayer() {
    _webViewController = WebViewController()..loadHtmlString('''
            <html>
              <body>
              <img src="$streamUrl" width=100% height=100% />
              </body>
            </html>
          ''');
  }

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
          child: BlocConsumer<SurvellianceCubit, SurvellianceState>(
            listener: (context, state) {
              if (state is SurvellianceErrorState) {
                SnackBarDialog.showErrorFlushBarMessage(
                    state.errorMessage, context);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    "Live Feed",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),

                  SizedBox(height: 10.h),

                  SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: WebViewWidget(controller: _webViewController)),

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
                        // Horizontal View Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MainButton(
                                isLoading: state is TiltUpLoadingState,
                                text: 'Tilt Up',
                                onPressed: () async {
                                  await BlocProvider.of<SurvellianceCubit>(
                                          context)
                                      .tiltUp();
                                },
                              ),
                            ),
                            SizedBox(width: 30.w),
                            Expanded(
                              child: MainButton(
                                isLoading: state is TiltDownLoadingState,
                                text: 'Tilt Down',
                                onPressed: () async {
                                  await BlocProvider.of<SurvellianceCubit>(
                                          context)
                                      .tiltDown();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),

                        // Center View Buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: MainButton(
                            isLoading: state is CenterLoadingState,
                            text: 'Center',
                            onPressed: () async {
                              await BlocProvider.of<SurvellianceCubit>(context)
                                  .center();
                            },
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // Vertical View Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MainButton(
                                isLoading: state is PanLeftLoadingState,
                                text: 'Pan Left',
                                onPressed: () async {
                                  await BlocProvider.of<SurvellianceCubit>(
                                          context)
                                      .panLeft();
                                },
                              ),
                            ),
                            SizedBox(width: 30.w),
                            Expanded(
                              child: MainButton(
                                isLoading: state is PanRightLoadingState,
                                text: 'Pan Right',
                                onPressed: () async {
                                  await BlocProvider.of<SurvellianceCubit>(
                                          context)
                                      .panRight();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      )),
    );
  }
}
