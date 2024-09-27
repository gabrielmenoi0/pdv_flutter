import 'package:pdv_windows/core/export/base_export.dart';

extension IntExtension on int {
  String get timerText {
    final secondsLeft = this;

    final formattedMinutesLeft = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final formattedSecondsLeft = (secondsLeft % 60).toString().padLeft(2, '0');

    return '$formattedMinutesLeft : $formattedSecondsLeft';
  }
}
extension CurrencyFormatter on num {
  String toMoney() {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(this);
  }
}
