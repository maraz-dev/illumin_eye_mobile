import 'package:flutter/material.dart';
import 'package:illumin_eye_mobile/views/theme/app_colors.dart';

class SnackBarDialog {
  /// Function to display error message of value [message] in a [context] and
  /// an optional function [where] to do after displaying message
  static showErrorFlushBarMessage(String message, BuildContext context,
      {bool shouldDismiss = true, Function? where}) {
    bool opened = true;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        useRootNavigator: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          if (shouldDismiss) {
            Future.delayed(const Duration(milliseconds: 2500), () {
              if (opened) {
                Navigator.of(buildContext, rootNavigator: false).pop();
              }
            }).then((value) {
              if (where != null) where();
            });
          }
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: AppColors.kErrorColor,
                child: SafeArea(
                  right: false,
                  bottom: false,
                  left: false,
                  child: Text(
                    message,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.kWhite,
                        ),
                  ),
                ),
              ),
            ),
          );
        }).then((value) => opened = false);
  }

  /// Function to display error message of value [message] in a [context] and
  /// an optional function [where] to do after displaying message
  static showSuccessFlushBarMessage(String message, BuildContext context,
      {bool shouldDismiss = true, Function? where}) {
    bool opened = true;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        useRootNavigator: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          if (shouldDismiss) {
            Future.delayed(const Duration(milliseconds: 2500), () {
              if (opened) {
                Navigator.of(buildContext, rootNavigator: false).pop();
              }
            }).then((value) {
              if (where != null) where();
            });
          }
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: AppColors.kSuccessColor,
                child: SafeArea(
                  right: false,
                  bottom: false,
                  left: false,
                  child: Text(
                    message,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.kWhite,
                        ),
                  ),
                ),
              ),
            ),
          );
        }).then((value) => opened = false);
  }
}
