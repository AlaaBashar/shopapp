import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> openNewPage(BuildContext context, Widget widget,
    {bool popPreviousPages = false}) {
  return Future<dynamic>.delayed(Duration.zero, () {
    if (!popPreviousPages) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => widget,
          settings: RouteSettings(arguments: widget),
        ),
      );
    } else {
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => widget,
              settings: RouteSettings(
                arguments: widget,
              )),
          (Route<dynamic> route) => false);
    }
  });
}

double getScreenWidth(BuildContext context, {bool realWidth = false}) {
  if (realWidth) {
    return MediaQuery.of(context).size.width;
  } //to preview widget like phone scale in preview

  if (kIsWeb) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.width / 4
        : MediaQuery.of(context).size.height / 4;
  }

  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.width
      : MediaQuery.of(context).size.height;
}

double getScreenHeight(BuildContext context, {bool realHeight = false}) {
  if (realHeight) {
    return MediaQuery.of(context).size.height;
  } //to preview widget like phone scale in preview
  if (kIsWeb) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.height / 1.4
        : MediaQuery.of(context).size.width / 1.4;
  }
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.height
      : MediaQuery.of(context).size.width;
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class ProgressCircleDialog {
  static bool _isShow = false;

  static show(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    _isShow = true;
  }

  static dismiss(BuildContext context) {
    if (_isShow) {
      Navigator.pop(context);
      _isShow = false;
    }
  }
}

class ShowToast {
  static FToast? fToast = FToast();

  static Widget toastDesign({
    String? message,
    Color? color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color ?? Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null ? Icon(icon) : const Icon(Icons.error),
          const SizedBox(
            width: 12.0,
          ),
          message != null ? Text(message) : const Text('Enter message'),
        ],
      ),
    );
  }

  static display({
    required BuildContext context,
    String? message,
    Color? color,
    IconData? icon,
  }) {
    fToast!.init(context);
    fToast!.showToast(
      child: toastDesign(
        message: message,
        color: color,
        icon: icon,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

// // Custom Toast Position
// fToast.showToast(
//     child: toast,
//     toastDuration: const Duration(seconds: 2),
//     positionedToastBuilder: (context, child) {
//       return Positioned(
//         child: child,
//         top: 16.0,
//         left: 16.0,
//       );
//     });
}
