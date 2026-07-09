import 'package:heritage_ui/screens/shared/app_language.dart';

class AppStrings {
  const AppStrings._({
    required this.loginPageTitle,
    required this.loginTitle,
    required this.usernameLabel,
    required this.passwordLabel,
    required this.loginButton,
    required this.manualLanguageButton,
    required this.loginError,
    required this.toggleToOtherLanguage,
    required this.welcomeAppBarTitle,
    required this.welcomeMessage,
    required this.homeTooltip,
    required this.heritageInfo,
    required this.managementArea,
    required this.managementAreaComingSoon,
    required this.locationSelectHint,
    required this.locationGoButton,
    required this.footerCopyright,
  });

  final String loginPageTitle;
  final String loginTitle;
  final String usernameLabel;
  final String passwordLabel;
  final String loginButton;
  final String manualLanguageButton;
  final String loginError;
  final String toggleToOtherLanguage;

  final String welcomeAppBarTitle;
  final String welcomeMessage;
  final String homeTooltip;
  final String heritageInfo;
  final String managementArea;
  final String managementAreaComingSoon;
  final String locationSelectHint;
  final String locationGoButton;
  final String footerCopyright;

  static const AppStrings arabic = AppStrings._(
    loginPageTitle: 'صفحة تسجيل الدخول',
    loginTitle: 'تسجيل الدخول',
    usernameLabel: 'اسم المستخدم',
    passwordLabel: 'كلمة المرور',
    loginButton: 'ابدأ',
    manualLanguageButton: 'اختيار اللغة يدويًا',
    loginError: 'اسم المستخدم أو كلمة المرور غير صحيحة ❌',
    toggleToOtherLanguage: 'Switch to English',
    welcomeAppBarTitle: 'واجهة المستخدم التراثية',
    welcomeMessage: 'مرحباً! إلى واجهة المستخدم التراثية',
    homeTooltip: 'الصفحة الرئيسية',
    heritageInfo: 'معلومات المواقع الأثرية',
    managementArea: 'إدارة المواقع الأثرية',
    managementAreaComingSoon: 'تحت الإنشاء - إدارة المناطق',
    locationSelectHint: 'اختر الموقع',
    locationGoButton: 'انتقل إلى الموقع',
    footerCopyright: '© 2024 Heritage UI. All rights reserved.',
  );

  static const AppStrings english = AppStrings._(
    loginPageTitle: 'Login Page',
    loginTitle: 'Login',
    usernameLabel: 'Username',
    passwordLabel: 'Password',
    loginButton: 'Login',
    manualLanguageButton: 'Choose language manually',
    loginError: 'Invalid username or password ❌',
    toggleToOtherLanguage: 'التبديل إلى العربية',
    welcomeAppBarTitle: 'Heritage UI',
    welcomeMessage: 'Welcome to Heritage UI',
    homeTooltip: 'Home',
    heritageInfo: 'Heritage Info',
    managementArea: 'Management Area',
    managementAreaComingSoon: 'Management Area Coming Soon...',
    locationSelectHint: 'Select Location',
    locationGoButton: "Let's Go",
    footerCopyright: '© 2024 Heritage UI. All rights reserved.',
  );

  static AppStrings of(AppLanguage language) {
    return language.isArabic ? arabic : english;
  }
}

class GlobalStrings {
  static const String languageSelectorAppTitle = 'Language Selector';
  static const String languageSelectorHeader = 'Language / اللغة';
  static const String languageSelectorPrompt =
      'Please select your language:\nيرجى اختيار لغتك المفضلة:';
  static const String arabicOption = '🇶🇦    العربية';
  static const String englishOption = '🇺🇸  English';
  static const String heritageMainPageTitle = 'Heritage UI Main Page';
  static const String bilingualWelcome =
      'Welcome! to Heritage UI \n مرحباً! إلى واجهة المستخدم التراثية ';
  static const String chooseLanguageButton = 'Choose Language \n اختر اللغة';
}
