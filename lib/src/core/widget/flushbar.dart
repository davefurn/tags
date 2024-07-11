import 'package:another_flushbar/flushbar.dart';
// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';

class Alert {
  static void showNotification({
    required BuildContext context,
    int notificationType = 0,
    String message = '',
    Duration? duration,
  }) {
    Flushbar(
      //padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: notificationType == 0
          ? const Color(0xFF64DD17)
          : const Color.fromARGB(255, 142, 19, 11),
      maxWidth: MediaQuery.of(context).size.width * 0.8,
      boxShadows: const [
        BoxShadow(
          color: TagColors.appThemeColor,
          offset: Offset(0, 2),
          blurRadius: 3,
        ),
      ],
      duration: duration ?? const Duration(seconds: 30),
      icon: notificationType == 1
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {
                  // context.router.pop();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            )
          : InkWell(
              onTap: () {
                // context.router.pop();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.check_circle_outline,
                color: Colors.black,
              ),
            ),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
      ),
    ).show(context);
  }

  static void showNotificationError({
    required BuildContext context,
    int notificationType = 0,
    String message = '',
    String? buttonText,
    Duration? duration,
    VoidCallback? onTap,
  }) {
    showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget) => TagDialog(
        title: 'Error',
        icon: const Icon(
          Icons.error,
          color: TagColors.red,
          size: 30,
        ),
        subtitle: message,
        onTap: onTap ??
            () {
              // context.router.pop();
              Navigator.pop(context);
            },
        buttonColor: TagColors.red,
        buttonText: buttonText ?? 'Dismiss',
      ),
      transitionDuration: duration ?? const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => const SizedBox(),
    );
  }
}
