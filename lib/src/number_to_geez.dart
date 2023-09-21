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
    while (number > 0) {
      // Get the rightmost digit of the number.
      int digit = number % 10;

      // Add the digit to the list.
      splitedDigits.add(digit);

      // Remove the rightmost digit from the number.
      number = number ~/ 10;
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
    for (int i = splitedDigits.length; i > 0; i--) {
      // Add the current component (power of 10) to the list.
      componentList.add(sum);

      // Multiply the sum by 10 for the next iteration.
      sum *= 10;
    }
    // Reverse the list to get the correct order of components.
    return componentList.reversed.toList();
  }

  /// Drives the Geez representation of the number.
  ///
  /// Returns the Geez numeric representation of the number.
  String _driveGeezRepresentation(List<int> splitedDigits, List componentList) {
    String geezRep = '';
    for (int index = 0; index < splitedDigits.length; index++) {
      // Check if the product of the current digit and its corresponding component
      // is present in the geezNumbers map.
      if (geezNumbers
          .containsKey(splitedDigits[index] * componentList[index])) {
        // Add the Geez representation of the product to the result.
        geezRep +=
            geezNumbers[splitedDigits[index] * componentList[index]] ?? '';
      } else {
        // If the product is not in the map, add the individual Geez representations
        // of the digit and its corresponding component to the result.
        String geezNum = geezNumbers[splitedDigits[index]] ?? '';
        String sthGeez = geezNumbers[componentList[index]] ?? '';
        geezRep += geezNum + sthGeez;
      }
    }
    // Return the final Geez representation of the number.
    return geezRep;
  }
}
