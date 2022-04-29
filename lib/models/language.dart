class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> langlist() {
    return <Language>[
      Language(1, 'English', '🇺🇸', 'en'),
      Language(2, 'مصرى', '🇪🇬', 'ar-EG'),
      Language(3, 'française', '🇫🇷', 'fr-FR'),
    ];
  }
}
