/// The `geezNumbers` constant provides a mapping between numeric values and their corresponding
/// Geez representations.
///
/// Geez is the script used for writing the Ge'ez language, which is an ancient South Semitic
/// language that is still used liturgically by the Ethiopian Orthodox Tewahedo Church and
/// Eritrean Orthodox Tewahdo Church. The Geez script has its own numeric system.
///
/// The `geezNumbers` constant combines three sub-constants: `oneToNine`, `tenToNinety`, and
/// `hundredTo1M`, which represent the Geez representations for numbers from 1 to 9, numbers
/// in the tens place (10, 20, 30, etc.), and numbers in the hundreds and higher places (100, 1000,
/// 10000, etc.), respectively.
///
/// Example usage:
/// ```dart
/// import 'geez/constants.dart';
///
/// void main() {
///   print(geezNumbers[5]); // Outputs '፭'
///   print(geezNumbers[40]); // Outputs '፵'
///   print(geezNumbers[1000]); // Outputs '፲፻'
/// }
/// ```
final geezNumbers = {
  0: '', // Zero is represented as an empty string in Geez.
  ...oneToNine,
  ...tenToNinety,
  ...hundredTo1M,
};

/// The `oneToNine` constant provides the Geez representations for numbers from 1 to 9.
final oneToNine = {
  1: '፩',
  2: '፪',
  3: '፫',
  4: '፬',
  5: '፭',
  6: '፮',
  7: '፯',
  8: '፰',
  9: '፱',
};

/// The `tenToNinety` constant provides the Geez representations for numbers in the tens place
/// (10, 20, 30, etc.).
final tenToNinety = {
  10: '፲',
  20: '፳',
  30: '፴',
  40: '፵',
  50: '፶',
  60: '፷',
  70: '፸',
  80: '፹',
  90: '፺',
};

/// The `hundredTo1M` constant provides the Geez representations for numbers in the hundreds and
/// higher places (100, 1000, 10000, etc.).
final hundredTo1M = {
  100: '፻',
  1000: '፲፻',
  10000: '፼',
  100000: '፲፼',
  1000000: '፻፼',
  10000000: '፲፻፼',
  100000000: '፼፼',
};
