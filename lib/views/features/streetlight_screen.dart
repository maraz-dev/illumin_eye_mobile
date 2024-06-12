// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illumin_eye_mobile/data/service.dart';
import 'package:illumin_eye_mobile/views/utils/app_images.dart';
import 'package:illumin_eye_mobile/views/utils/snackbar.dart';
import 'package:illumin_eye_mobile/views/widgets/main_button.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StreetlightScreen extends StatefulWidget {
  static const routeName = 'streetlight-screen';
  const StreetlightScreen({super.key});

  @override
  State<StreetlightScreen> createState() => _StreetlightScreenState();
}

class _StreetlightScreenState extends State<StreetlightScreen> {
  // Boolean to hold the Loading State
  bool _isTurnOnLoading = false;
  bool _isTurnOffLoading = false;
  bool _isLightLoading = false;

  /// This method isn't meant to be here (Clean code and all), but this is meant to handle the request
  Future<String> _sendStreetlightRequest(String endpoint) async {
    final url = '$esp32Url/$endpoint';
    try {
      // Change the State of the button to Loading before making the request
      setState(() {
        if (endpoint == 'H') {
          _isTurnOnLoading = true;
        } else if (endpoint == 'L') {
          _isTurnOffLoading = true;
        } else {
          _isLightLoading = true;
        }
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (endpoint == 'H') {
          SnackBarDialog.showSuccessFlushBarMessage('Streetlight ON', context);
          return 'Streetlight ON';
        } else if (endpoint == 'L') {
          return 'Streetlight OFF';
        } else if (endpoint == '') {
          final parsedResponse = jsonDecode(response.body);
          return parsedResponse['lightIntensity'].toString();
        } else {
          return '';
        }
      } else {
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
        SnackBarDialog.showErrorFlushBarMessage(
            response.statusCode.toString(), context);
        setState(() {
          if (endpoint == 'H') {
            _isTurnOnLoading = false;
          } else if (endpoint == 'L') {
            _isTurnOffLoading = false;
          } else {
            _isLightLoading = false;
          }
        });
        throw response.statusCode;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      SnackBarDialog.showErrorFlushBarMessage(e.toString(), context);
      setState(() {
        if (endpoint == 'H') {
          _isTurnOnLoading = false;
        } else if (endpoint == 'L') {
          _isTurnOffLoading = false;
        } else {
          _isLightLoading = false;
        }
      });
      throw e.toString();
    }
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
        child: Column(
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
                    isLoading: _isTurnOnLoading,
                    text: 'Turn On',
                    padding: 40,
                    onPressed: () async => await _sendStreetlightRequest('H'),
                  ),
                  SizedBox(height: 20.h),

                  // Turn OFF
                  MainButton(
                    isLoading: _isTurnOffLoading,
                    text: 'Turn Off',
                    padding: 40,
                    onPressed: () async => await _sendStreetlightRequest('L'),
                  ),
                  SizedBox(height: 20.h),

                  // Automatic
                  MainButton(
                      isLoading: _isLightLoading,
                      text: 'Automatic',
                      padding: 40,
                      onPressed: () async => await _sendStreetlightRequest('')),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
