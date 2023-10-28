import 'constants.dart';
import 'dart:math';

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

    // Calculate the Arabic representation of the Geez number.
    final arabicRepresentation = _driveArabicRepresentation(this);

    return arabicRepresentation;
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
  int _driveArabicRepresentation(String GeezNum) {
    var elfyosh = ['፻፼፼፼', '፼፼፼', '፻፼፼', '፼፼', '፻፼', '፼', '፻', ''];
    let num = 0;
    let before_elf = '';
    let asrand = '';
    for(let i = 0; i < elfyosh.length; i++){
      if(i < elfyosh.length - 1){
        if(GeezNum.contains(elfyosh[i])){
          before_elf = GeezNum.substring(0, GeezNum.indexOf(elfyosh[i]) + elfyosh[i].length);
          GeezNum = GeezNum.substring(GeezNum.indexOf(elfyosh[i]) + elfyosh[i].length, GeezNum.length)
          if(before_elf.length - elfyosh[i].length == 2){
            asrand = before_elf.substring(0, 2);
            num += ((geezNumbers[asrand[0]] + geezNumbers[asrand[1]]) * geezNumbers[elfyosh[i]]);
          }
          else if(before_elf.length - elfyosh[i].length == 1){
            asrand = before_elf[0];
            num += (geezNumbers[asrand] * geezNumbers[elfyosh[i]]);
          }
          else{
            num += geezNumber[elfyosh[i]];
          }
        }
      }
      else if(i == elfyosh.length - 1){
        if(GeezNum.length == 2){
          num += geezNumbers[GeezNum[0]] + geezNumbers[GeezNum[1]];
        }
        else if(GeezNum.length == 1){
          num += geezNumbers[GeezNum];
        }
      }
    }
    return num;
}
