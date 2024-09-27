import 'package:pdv_windows/core/constants/app/regex_constants.dart';
import 'package:pdv_windows/core/export/base_export.dart';

extension StringLocalization on String {
  String get locale => this.tr();
}

extension ImagePathExtension on String {
  String get toSVG => 'assets/svg/$this.svg';
  String get toImage => 'assets/image/$this.png';
}

extension ParseDate on String {
  DateTime get toDateTimeLocal => DateTime.parse(this).toLocal();

  DateTime get toDateTime => DateTime.parse(this);

  String get toDateTimeLocalFormat =>
      DateFormat("HH:mm").format(toDateTimeLocal);

  String get toDateTimeFormat => DateFormat("HH:mm").format(toDateTime);

  String get toDateDayFormat =>
      DateFormat("dd/MM/yyyy").format(toDateTimeLocal);

  int get toInt => int.tryParse(this) ?? 0;

  String get toDateFullFormat =>
      DateFormat("dd/MM/yyyy").format(toDateTimeLocal);
}

extension CleanMask on String {
  String get removeMask => this
      .replaceAll(RegExp(StringRegexConstants.instance.removeMaskRegex), '');

  String get applyCensor =>
      this.replaceRange(0, this.length < 4 ? 0 : this.length - 4, "** *****-");
}

extension FieldsValidation on String {
  bool get isValidEmail => isNotEmpty
      ? RegExp(StringRegexConstants.instance.emailRegex).hasMatch(this)
      : false;

  bool get isValidPassword => isNotEmpty
      ? RegExp(StringRegexConstants.instance.passwordRegex).hasMatch(this)
      : false;

  bool isValidCompare(String compare) => isNotEmpty ? this == compare : false;

  bool get isValidFullName => isNotEmpty
      ? RegExp(StringRegexConstants.instance.fullNameRegex).hasMatch(this)
      : false;

  bool get isValidDate => isNotEmpty
      ? RegExp(StringRegexConstants.instance.dateRegex).hasMatch(this)
      : false;

  bool get isValidDateAndFuture {
    final regex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(\d{4})$');

    if (!regex.hasMatch(this)) {
      return false;
    }

    final parts = this.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    try {
      final inputDate = DateTime(year, month, day);

      final now = DateTime.now();

      return inputDate.isBefore(now);
    } catch (e) {
      return false;
    }

  }

  bool get isValidCpf => isNotEmpty
      ? RegExp(StringRegexConstants.instance.cpfRegex).hasMatch(this)
      : false;

  bool get isValidCnpj => isNotEmpty
      ? RegExp(StringRegexConstants.instance.cnpjRegex).hasMatch(this)
      : false;

  bool get isValidCellPhone => isNotEmpty
      ? RegExp(StringRegexConstants.instance.cellPhoneRegex).hasMatch(this)
      : false;

  bool get isValidPhone => isNotEmpty
      ? RegExp(StringRegexConstants.instance.cellPhoneRegex).hasMatch(this)
      : false;

  bool get isValidCep => isNotEmpty
      ? RegExp(StringRegexConstants.instance.cepRegex).hasMatch(this)
      : false;
}
