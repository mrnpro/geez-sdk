import 'constants.dart';

/// A utility extension for converting Geez numbers to Arabic numbers.
///
/// This extension provides a `toArabic` method on String objects, allowing you
/// to convert Geez numbers represented as strings to their Arabic numeric
/// equivalents.
///
/// Example usage:
/// ```dart
/// String geezNumber = '፩፪፻'; // Geez number representation of 112
/// num arabicNumber = geezNumber.toArabic(); // Converts to 112
/// ```
///
/// Note: This extension assumes a mapping of Geez numbers to their Arabic
/// numeric representations is available in the `geezNumbers` and `hundredTo1M`
/// maps defined in the 'constants.dart' file.
extension GeezToArabicConvertor on String {
  /// Converts a Geez number string to its Arabic numeric equivalent.
  ///
  /// Returns the numeric representation of the Geez number.
  num toArabic() {
    // The exact user input can be found in the `geezNumbers` list.
    final result = _quickReverseFind(this);
    if (result != -1) {
      return result;
    }

    // Split the String into individual characters.
    List<String> separatedGeezs = _splitNumbersStrings(this);

    // Calculate the Arabic representation of the Geez number.
    final arabicRepresentation = _driveArabicRepresentation(separatedGeezs);

    return arabicRepresentation;
  }

  /// Splits a string into individual characters.
  ///
  /// Returns a List of individual character strings.
  List<String> _splitNumbersStrings(String string) {
    List<String> splitedStrings = [];
    for (var rune in string.runes) {
      var character = String.fromCharCode(rune);
      splitedStrings.add(character);
    }
    return splitedStrings;
  }

  /// Performs a quick reverse find operation on the `geezNumbers` map.
  ///
  /// Returns the corresponding Arabic numeric value of the Geez number if found,
  /// otherwise returns -1.
  int _quickReverseFind(String geez) {
    return geezNumbers.keys
        .firstWhere((key) => geezNumbers[key] == geez, orElse: () => -1);
  }

  /// Calculates the Arabic representation of the Geez number.
  ///
  /// Returns the Arabic numeric representation of the Geez number.
  int _driveArabicRepresentation(List<String> separatedGeezs) {
    int sum = 0;
    num? indexToJump;
    for (var i = 0; i < separatedGeezs.length; i++) {
      // `indexToJump` is the next index we multiplied with the last index,
      // so we don't have to check next time as we have already used it.
      if (indexToJump == i) {
        continue;
      }

      // The current index Geez.
      final currentGeez = separatedGeezs[i];
      final nextIndex = i + 1;

      String? nextGeez;
      // Check if the index exists in the `separatedGeezs` List to prevent an index out of bounds exception.
      if (nextIndex >= 0 && nextIndex < separatedGeezs.length) {
        nextGeez = separatedGeezs[i + 1];
      }

      // Search the key using value and get the current ASCII value.
      final asciiCurrent = geezNumbers.keys.firstWhere(
          (key) => geezNumbers[key] == currentGeez,
          orElse: () => -1);

      // Search the key using value and get the next ASCII value.
      final asciiNext = hundredTo1M.keys
          .firstWhere((key) => hundredTo1M[key] == nextGeez, orElse: () => -1);

      if (asciiNext != -1) {
        indexToJump = i + 1;
        sum += (asciiNext * asciiCurrent);
      } else {
        sum += asciiCurrent;
      }
    }
    return sum;
  }
}
