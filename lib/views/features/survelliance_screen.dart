import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:illumin_eye_mobile/views/theme/app_colors.dart';
import 'package:illumin_eye_mobile/views/widgets/main_button.dart';
import 'package:video_player/video_player.dart';

class SurvellianceScreen extends StatefulWidget {
  static const routeName = 'survelliance-screen';
  const SurvellianceScreen({super.key});

  @override
  State<SurvellianceScreen> createState() => _SurvellianceScreenState();
}

class _SurvellianceScreenState extends State<SurvellianceScreen> {
  // Controller for the Video
  late CachedVideoPlayerController _playerController;
  late CustomVideoPlayerController _customController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  void initializeVideoPlayer() {
    _playerController = CachedVideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ..initialize().then((_) {
        setState(() {});
        _playerController.play();
      });
    _customController = CustomVideoPlayerController(
        context: context, videoPlayerController: _playerController);
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
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Small Frame Video

              _playerController.value.isInitialized
                  ? CustomVideoPlayer(
                      customVideoPlayerController: _customController)
                  : const Center(
                      child: SpinKitDualRing(
                        color: AppColors.kPrimaryColor,
                        size: 150,
                        lineWidth: 2,
                      ),
                    ),

              // _playerController.value.isInitialized
              //     ? AspectRatio(
              //         aspectRatio: _playerController.value.aspectRatio,
              //         child: CachedVideoPlayer(_playerController),
              //       )
              //     : const Placeholder(
              //         fallbackHeight: 250,
              //       ),
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
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 60),
                    //   child: MainButton(text: 'View Full Screen'),
                    // ),
                    // SizedBox(height: 30.h),

                    // Horizontal View Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: MainButton(text: 'Tilt Up')),
                        SizedBox(width: 30.w),
                        const Expanded(child: MainButton(text: 'Tilt Down')),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // Center View Buttons
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: MainButton(text: 'Center'),
                    ),
                    SizedBox(height: 30.h),

                    // Vertical View Buttons
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
