import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/export/base_export.dart';
import 'package:pdv_windows/core/init/lang/locale_keys.g.dart';
import 'package:pdv_windows/core/init/navigation/navigation_service.dart';

class SnackBarService {
  static void errorSnackBar(String message) {
    var context = NavigationService.navigatorKey.currentState!.context;
    Flushbar(
      icon: Icon(Icons.warning_amber_rounded,color: Colors.white),
      message: message,
      duration: const Duration(seconds: 4),
      isDismissible: false,
      backgroundColor: Colors.orange,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      positionOffset: 0.5,
    ).show(context);
  }

  static void successSnackBar(String message) {
    var context = NavigationService.navigatorKey.currentState!.context;
    Flushbar(
      icon: Icon(Icons.check_circle_outline_outlined,color: Colors.white),
      message: message,
      duration: const Duration(seconds: 4),
      isDismissible: false,
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      positionOffset: 0.5,
    ).show(context);
  }

  static Future<bool> presentDialog(
      {required String title,
        required String message,
        required String firstBtn,
        required String secondBtn,
        Widget? icon,
        bool isSuccess = false}) async {
    var context = NavigationService.navigatorKey.currentState!.context;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: icon,
            contentPadding: context.padding.normal,
            actionsPadding: context.padding.normal,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            title: Text(
              title.tr(),
              textAlign: TextAlign.center,
              style: context.general.textTheme.headlineSmall?.copyWith(
                  color: isSuccess ? Color(0xff19B377) : Color(0xffF4483B)),
            ),
            content: Text(message.tr(),
                textAlign: TextAlign.center,
                style: context.general.textTheme.bodyLarge),
            actions: isSuccess
                ? [
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: Size(kMinInteractiveDimension * 2,
                      kMinInteractiveDimension),
                ),
                child: Text(LocaleKeys.button_ok.tr()),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ]
                : [
              Visibility(
                visible: firstBtn.isNotEmpty,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(kMinInteractiveDimension * 2,
                        kMinInteractiveDimension),
                  ),
                  child: Text(firstBtn.tr()),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: Size(kMinInteractiveDimension * 2,
                      kMinInteractiveDimension),
                ),
                child: Text(secondBtn.tr()),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        }).then((value) => value == null ? false : value);
  }

}