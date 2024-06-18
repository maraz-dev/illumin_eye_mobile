import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:illumin_eye_mobile/views/theme/app_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final double? padding;
  final bool isLoading;
  final Function()? onPressed;
  const MainButton({
    super.key,
    required this.text,
    this.onPressed,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: isLoading
            ? const SpinKitDualRing(
                color: AppColors.kWhite,
                size: 23,
                lineWidth: 2,
              )
            : Center(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
      ),
    );
  }
}
