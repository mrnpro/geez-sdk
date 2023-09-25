import 'constants.dart';

/// A utility extension for converting numbers to Geez numbers.
///
/// This extension provides a `toGeez` method on `int` objects,
/// allowing you to convert numbers to Geez numbers represented as strings.
///
/// Example usage:
/// ```dart
/// int number = 200;
///
/// String geezNumber = number.toGeez(); // Converts to '፪፻'
/// ```
extension NumberToGeezConvertor on int {
  /// Converts a number to its Geez numeric representation.
  ///
  /// Returns the Geez representation of the number.
  String toGeez() {
    // Check if the number is already present in the geezNumbers map.
    if (geezNumbers.containsKey(this)) {
      return geezNumbers[this] ?? '';
    }

    // Split the number into individual digits.
    final splitedDigits = _splitNumbers(this);

    // Calculate the component list for forming the Geez representation.
    final componentList = _getComponents(splitedDigits);

    // Drive the Geez representation of the number.
    final geezRepresentation =
        _driveGeezRepresentation(splitedDigits, componentList);

    return geezRepresentation;
  }

  /// Splits a number into individual digits.
  ///
  /// Returns a list of individual digits.
  List<int> _splitNumbers(int number) {
    List<int> splitedDigits = [];
    int iter=1;
    while (number >= 0) {  //continues one more step ahead than it normally would when the number of digits are odd (so that we can consistently use the components)
      // Get the rightmost two-digits of the number.
      if(number > 0){
      int digito = number % 100;

      // Add the digit to the list keeping their placements (for 26 -> 20 , 6)
      for(int i=0; (digito>0 || iter%2 == 1); i++){
        //gets the individual digits
          int digit = digito%10;
          if(i==1){
              digit = digito*10;
          }
          splitedDigits.add(digit);
          digito = digito ~/ 10;
          iter++;
      }
        // Remove the rightmost two-digits from the number.
        number = number ~/ 100;
      } else if(number == 0 && iter%2 == 1){
        splitedDigits.add(number);
        break;
      } else {
        break;
      }
    }
    // Reverse the list to get the correct order of digits.
    return splitedDigits.reversed.toList();
  }

  /// Calculates the component list for forming the Geez representation.
  ///
  /// Returns a list of components.
  List<int> _getComponents(List<int> splitedDigits) {
    int sum = 1;
    List<int> componentList = [];

    // Iterate over the digits in reverse order.
    for (int i = splitedDigits.length; i > 0; i=i-2) {
      // Add the current component (power of 100) to the list.

      componentList.add(sum);

      // Multiply the sum by 100 for the next iteration.
      sum *= 100;
    }
    // Reverse the list to get the correct order of components.
    return componentList.reversed.toList();
  }

  /// Drives the Geez representation of the number.
  ///
  /// Returns the Geez numeric representation of the number.
  String _driveGeezRepresentation(List<int> splitedDigits, List componentList) {
    String geezRep = '';
    for (int index = 0, j=0; j < componentList.length; index=index+2, j++) {
      // Check if the product of the current digit and its corresponding component
      // is present in the geezNumbers map.
      if (geezNumbers
          .containsKey(componentList[j]) && splitedDigits[index] == 0 && splitedDigits[index + 1] == 1 && componentList[j] != 1) {
        // Add the Geez representation of the product to the result.
        geezRep +=
            geezNumbers[componentList[j]] ?? '';
      } else if(geezNumbers
          .containsKey(splitedDigits[index] * componentList[j]) && componentList[j] != 1){
        geezRep +=
            geezNumbers[splitedDigits[index + 1] * componentList[j]] ?? '';
      } else {
        // If the product is not in the map, add the individual Geez representations
        // of the digit and its corresponding component to the result.
        String geezNum1 = geezNumbers[splitedDigits[index]] ?? '';
        String geezNum2 = geezNumbers[splitedDigits[index+1]] ?? '';
        String sthGeez = geezNumbers[componentList[j]] ?? '';
        geezRep += geezNum1 + geezNum2 + sthGeez;
      }
    }
    // Return the final Geez representation of the number.
    return geezRep;
  }
}
