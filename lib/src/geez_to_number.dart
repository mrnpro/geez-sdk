import 'constants.dart';
import "dart:math";

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
  int _driveArabicRepresentation(String geezNum) {
    List<String> elfyosh = ['፻፼፼፼', '፼፼፼', '፻፼፼', '፼፼', '፻፼', '፼', '፻', ''];
    List<String> ando = ['፩', '፪', '፫', '፬', '፭', '፮', '፯', '፰', '፱'];
    List<String> asro = ['፲', '፳', '፴', '፵', '፶', '፷', '፸', '፹', '፺'];
    int numeric = 0;
    int expo = 14;
    int mult = (pow(10, expo)).toInt();
    String beforeElf = '';
    String asrand = '';
    for(int i = 0; i < elfyosh.length; i++){
      if(i < elfyosh.length - 1){
        if(geezNum.contains(elfyosh[i])){
          beforeElf = geezNum.substring(0, geezNum.indexOf(elfyosh[i]) + elfyosh[i].length);
          geezNum = geezNum.substring(geezNum.indexOf(elfyosh[i]) + elfyosh[i].length, geezNum.length);
          if(beforeElf.length - elfyosh[i].length == 2){
            asrand = beforeElf.substring(0, 2);
            numeric += ((((asro.indexOf(asrand[0]) + 1) * 10) + (ando.indexOf(asrand[1]) + 1)) * mult).toInt();
          }
          else if(beforeElf.length - elfyosh[i].length == 1){
            asrand = beforeElf[0];
            if(ando.contains(asrand)){
              numeric += ((ando.indexOf(asrand) + 1)).toInt();
            }
            else if(asro.contains(asrand)){
              numeric += ((asro.indexOf(asrand) + 1) * 10).toInt();
            }
          }
          else{
            numeric += mult;
          }
        }
        expo -= 2;
        mult = (pow(10, expo)).toInt;
      }
      else if(i == elfyosh.length - 1){
        if(geezNum.length == 2){
          numeric += (((asro.indexOf(geezNum[0]) + 1) * 10) + (ando.indexOf(geezNum[1]) + 1)).toInt();
        }
        else if(geezNum.length == 1){
          if(ando.contains(geezNum)){
            numeric += ((ando.indexOf(geezNum) + 1)).toInt();
          }
          else if(asro.contains(geezNum)){
            numeric += ((asro.indexOf(geezNum) + 1) * 10).toInt();
          }
        }
      }
    }
    return numeric;
}
}
