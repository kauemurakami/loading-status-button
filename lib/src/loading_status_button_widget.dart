import 'package:flutter/material.dart';
import 'package:loading_status_button/src/loading_status_button_controller.dart';
import 'package:loading_status_button/src/status_button.dart';

/// A customizable button widget that changes its appearance based on the status.
///
/// The `LoadingStatusButtonWidget` reacts to different states managed by a
/// [LoadingStatusButtonController]. The button can display a loading spinner,
/// an error icon, a success icon, or its normal state depending on the current status.
///
/// The widget can be customized in terms of colors, dimensions, and animations.
/// The `callback` function is executed when the button is in the enabled state and pressed.
// ignore: must_be_immutable
class LoadingStatusButtonWidget extends StatelessWidget {
  /// Creates a [LoadingStatusButtonWidget].
  ///
  /// - [callback]: The function to be executed when the button is enabled and pressed.
  /// - [controller]: The controller that manages the button's current status.
  /// - [widget]: The widget to be displayed inside the button when it is not in a special state (loading, error, success).
  /// - [buttonColor]: The color of the button in its normal state.
  /// - [buttonDisableColor]: The color of the button when it is disabled.
  /// - [errorIconColor]: The color of the error icon.
  /// - [loadingColor]: The color of the loading spinner.
  /// - [succesIconColor]: The color of the success icon.
  /// - [highlightColor]: The color when the button is pressed and held.
  /// - [splashColor]: The splash color when the button is tapped.
  /// - [height]: The height of the button.
  /// - [maxWidth]: The maximum width of the button.
  /// - [minWidth]: The minimum width of the button during the loading state.
  /// - [borderRadius]: The radius of the button's corners.
  /// - [animationDurationMilliseconds]: The duration of the button's transition animations.
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

  /// The controller that manages the button's current status.
  final LoadingStatusButtonController controller;

  /// The function to be executed when the button is enabled and pressed.
  final VoidCallback callback;

  /// The widget to be displayed inside the button in its normal state.
  final Widget widget;

  /// The color of the button in its normal state.
  Color buttonColor;

  /// The color of the loading spinner.
  Color loadingColor;

  /// The color of the error icon.
  Color errorIconColor;

  /// The color of the success icon.
  Color succesIconColor;

  /// The color when the button is pressed and held.
  Color highlightColor;

  /// The splash color when the button is tapped.
  Color splashColor;

  /// The color of the button when it is disabled.
  Color buttonDisableColor;

  /// The minimum width of the button during the loading state.
  double minWidth;

  /// The maximum width of the button.
  double maxWidth;

  /// The height of the button.
  double height;

  /// The radius of the button's corners.
  double borderRadius;

  /// The duration of the button's transition animations, in milliseconds.
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
