import 'package:flutter/material.dart';

enum SnackBarType { error, warning, success }

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class AppMessenger {
  static void e(
    String error, {
    Duration? duration,
    String? actionText,
    Function()? ontap,
    bool enableIcon = true,
    bool enableBottomPadding = false,
    EdgeInsets? margin,
  }) {
    try {
      snackBarKey.currentState?.hideCurrentSnackBar();
      snackBarKey.currentState?.showSnackBar(
        showInSnackBar(
          enableIcon: enableIcon,
          value: error,
          duration: duration,
          actionText: actionText,
          onPressed: ontap,
          snackBarType: SnackBarType.error,
          enableBottomPadding: enableBottomPadding,
          margin: margin,
        ),
      );
    } catch (_) {}
  }

  static void w(
    String error, {
    Duration? duration,
    String? actionText,
    Function()? ontap,
    bool enableIcon = true,
    bool enableBottomPadding = false,
  }) {
    try {
      snackBarKey.currentState?.hideCurrentSnackBar();
      snackBarKey.currentState?.showSnackBar(
        showInSnackBar(
          enableIcon: enableIcon,
          value: error,
          duration: duration,
          actionText: actionText,
          onPressed: ontap,
          snackBarType: SnackBarType.warning,
          enableBottomPadding: enableBottomPadding,
        ),
      );
    } catch (_) {}
  }

  static void s(
    String error, {
    Duration? duration,
    String? actionText,
    Function()? ontap,
    bool enableIcon = true,
    enableBottomPadding,
    EdgeInsets? margin,
  }) {
    try {
      snackBarKey.currentState?.hideCurrentSnackBar();
      snackBarKey.currentState?.showSnackBar(
        showInSnackBar(
          enableIcon: enableIcon,
          value: error,
          duration: duration,
          actionText: actionText,
          onPressed: ontap,
          snackBarType: SnackBarType.success,
          margin: margin,
        ),
      );
    } catch (_) {}
  }
}

SnackBar showInSnackBar({
  required String value,
  Duration? duration,
  String? actionText,
  Function()? onPressed,
  SnackBarType snackBarType = SnackBarType.error,
  required bool enableIcon,
  bool enableBottomPadding = false,
  EdgeInsets? margin,
}) {
  Color getColor() {
    switch (snackBarType) {
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.warning:
        return Colors.orange;
    }
  }

  return SnackBar(
    duration: duration ?? const Duration(milliseconds: 1500),
    elevation: 0,
    backgroundColor: getColor(),
    behavior: SnackBarBehavior.floating,
    margin:
        margin ??
        (enableBottomPadding
            ? const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 100)
            : const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0)),
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Expanded(child: Text(value))],
    ),
    action:
        onPressed != null
            ? SnackBarAction(
              textColor: Colors.black,
              label: actionText ?? 'Ok',
              onPressed: onPressed,
            )
            : null,
  );
}
