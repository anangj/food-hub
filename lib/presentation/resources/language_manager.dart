enum LanguageType { ENGLISH, INDONESIAN }

const String ENGLISH = "en";
const String INDONESIAN = "id";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.INDONESIAN:
        return INDONESIAN;
    }
  }
}
