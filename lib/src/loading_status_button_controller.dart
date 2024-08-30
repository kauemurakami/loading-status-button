import 'package:flutter/cupertino.dart';
import 'package:loading_status_button/src/status_button.dart';

class LoadingStatusButtonController extends ChangeNotifier {
  LoadingStatusButtonController({this.initialStatus = StatusButton.enable}) {
    // Inicialize o ValueNotifier com o valor inicial
    status = ValueNotifier<StatusButton>(initialStatus);
    // Notifique os ouvintes que o status foi inicializado
    status.addListener(() {
      notifyListeners();
    });
  }
  final StatusButton initialStatus;
  late ValueNotifier<StatusButton> status;

  ValueNotifier<StatusButton> get currentStatus => status;
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
