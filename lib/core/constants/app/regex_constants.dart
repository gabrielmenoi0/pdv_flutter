class StringRegexConstants {
  StringRegexConstants._init();
  static StringRegexConstants? _instance;
  static StringRegexConstants get instance {
    if (_instance != null) return _instance!;

    _instance = StringRegexConstants._init();
    return _instance!;
  }

  final String removeMaskRegex =
      r'''[!@#$%^&*()_+\-=[\]{};\'\\:"|,.<>/?\s]''';

  final String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\w-]+\.[a-zA-Z]+";

  final String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';

  final String fullNameRegex =
      r"^[A-zÀ-Ÿ][A-zÀ-ÿ']+\s([A-zÀ-ÿ']\s?)*[A-zÀ-Ÿ][A-zÀ-ÿ']+ ?";

  final String dateRegex =
      r"^(\d{4})[-.\/](\d{2})[-.\/](\d{2})";

  final String cpfRegex =
      r"^\d{3}\x2E\d{3}\x2E\d{3}\x2D\d{2}$";

  final String cnpjRegex =
      r"^\d{2}.\d{3}.\d{3}/\d{4}-\d{2}$";

  final String cellPhoneRegex =
      r"^\(\d{2,}\) \d{4,}\-\d{4}";

  final String phoneRegex =
      r"^\(\d{2,}\) \d{4,}\-\d{4}";

  final String cepRegex =
      r"^\d{2}\d{3}[-]\d{3}$";
}