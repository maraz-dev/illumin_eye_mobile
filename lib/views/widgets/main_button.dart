import 'package:flutter/material.dart';
import 'package:illumin_eye_mobile/views/theme/app_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final double? padding;
  final Function()? onPressed;
  const MainButton({
    super.key,
    required this.text,
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 90, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
