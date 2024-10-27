// ignore_for_file: constant_identifier_names

class Constants {

  // API URL
  static const String baseUrl = 'http://localhost:3000/api/v1';
  //static const String baseUrl = 'https://rehaishkikhwaish.site/api/v1';

  // SharedPreferences Keys
  static const String FONT_SIZE_KEY = 'fontSize';
  static const String FONT_FAMILY_KEY = 'fontFamily';
  static const String IS_GRID_VIEW_KEY = 'isGridView';
  static const String IS_LIST_VIEW_KEY = 'isListView';
  static const String BOOKMARKS_KEY = 'bookmarks';

  // Font Family Options
  static const String FONT_FAMILY_RALEWAY = 'Raleway';
  static const String FONT_FAMILY_ROBOTO = 'Roboto';
  static const String FONT_FAMILY_LEXEND = 'Lexend';

  // Font Size Limits
  static const double FONT_SIZE_MIN = 9.0;
  static const double FONT_SIZE_MAX = 33.0;

  // Other Constants
  static const List<String> FONT_FAMILIES = [
    FONT_FAMILY_RALEWAY,
    FONT_FAMILY_ROBOTO,
    FONT_FAMILY_LEXEND,
  ];

}
