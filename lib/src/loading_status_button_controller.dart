import 'package:flutter/material.dart';
import 'package:loading_status_button/src/status_button.dart';

/// A controller class that manages the state of a loading status button.
///
/// This controller uses a [ValueNotifier] to track the current status
/// of the button, allowing it to handle various states such as `loading`,
/// `error`, `success`, `enable`, and `disable`.
class LoadingStatusButtonController extends ChangeNotifier {
  /// Creates a [LoadingStatusButtonController] with an optional initial status.
  ///
  /// The [initialStatus] parameter defines the initial state of the button,
  /// defaulting to [StatusButton.enable] if not provided.
  LoadingStatusButtonController({this.initialStatus = StatusButton.enable}) {
    status = ValueNotifier<StatusButton>(initialStatus);
    status.addListener(() {
      notifyListeners();
    });
  }

  /// The initial status of the button when the controller is created.
  ///
  /// Defaults to [StatusButton.enable] if not explicitly set.
  final StatusButton initialStatus;

  /// A [ValueNotifier] that holds the current status of the button.
  ///
  /// This notifier is used to track the button's state and trigger updates
  /// in the UI when the status changes.
  late ValueNotifier<StatusButton> status;

  /// Returns the current status of the button as a [ValueNotifier].
  ///
  /// This can be used by the UI to listen for changes and update accordingly.
  ValueNotifier<StatusButton> get currentStatus => status;

  /// Updates the status of the button.
  ///
  /// [s]: The new status to be set for the button. It should be of type [StatusButton].
  Future<void> setStatus(StatusButton s) async {
    if (s == StatusButton.error || s == StatusButton.success) {
      status.value = s;
      await Future.delayed(const Duration(milliseconds: 800));
    } else {
      status.value = s;
    }
    notifyListeners();
  }
}
