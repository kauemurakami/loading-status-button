import 'package:flutter/material.dart';
import 'package:loading_status_button/src/loading_status_button_controller.dart';
import 'package:loading_status_button/src/status_button.dart';

// ignore: must_be_immutable
class LoadingStatusButtonWidget extends StatelessWidget {
  LoadingStatusButtonWidget({
    required this.callback,
    required this.controller,
    required this.widget,
    this.buttonColor = Colors.black,
    this.buttonDisableColor = Colors.grey,
    this.errorIconColor = Colors.red,
    this.loadingColor = Colors.white,
    this.succesIconColor = Colors.green,
    this.highlightColor = Colors.grey,
    this.splashColor = Colors.white,
    this.height = 50.0,
    this.maxWidth = 240.0,
    this.minWidth = 50.0,
    this.borderRadius = 6.0,
    this.animationDurationMilliseconds = 600,
    super.key,
  });
  final LoadingStatusButtonController controller;
  final VoidCallback callback;
  final Widget widget;
  Color buttonColor;
  Color loadingColor;
  Color errorIconColor;
  Color succesIconColor;
  Color highlightColor;
  Color splashColor;
  Color buttonDisableColor;
  double minWidth = 50, maxWidth = 240, height = 50, borderRadius;
  int animationDurationMilliseconds;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.status,
      builder: (context, value, child) {
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: value == StatusButton.disable
                  ? buttonDisableColor
                  : buttonColor,
              shape: value == StatusButton.loading
                  ? BoxShape.circle
                  : BoxShape.rectangle,
            ),
            duration: value == StatusButton.loading
                ? const Duration(milliseconds: 50)
                : Duration(milliseconds: animationDurationMilliseconds),
            // curve: Curves.bounceIn,
            width: value == StatusButton.loading ? minWidth : maxWidth,
            height: height,
            child: value == StatusButton.loading
                ? Container(
                    width: minWidth,
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: loadingColor,
                    ),
                  )
                : value == StatusButton.error
                    ? Container(
                        width: minWidth,
                        height: height,
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          size: 36.0,
                          weight: 16.0,
                          color: errorIconColor,
                        ),
                      )
                    : value == StatusButton.success
                        ? Container(
                            width: minWidth,
                            height: height,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.check,
                              size: 36.0,
                              weight: 16.0,
                              color: succesIconColor,
                            ),
                          )
                        : MaterialButton(
                            splashColor: splashColor,
                            highlightColor: highlightColor,
                            elevation: .0,
                            color: value == StatusButton.disable
                                ? buttonDisableColor
                                : buttonColor,
                            onPressed: () async => value == StatusButton.enable
                                ? callback()
                                : null,
                            shape: const RoundedRectangleBorder(),
                            child: widget,
                          ),
          ),
        );
      },
    );
  }
}
