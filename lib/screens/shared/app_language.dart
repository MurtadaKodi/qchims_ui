enum AppLanguage { arabic, english }

extension AppLanguageX on AppLanguage {
  bool get isArabic => this == AppLanguage.arabic;

  String get code => isArabic ? 'arabic' : 'english';
}
