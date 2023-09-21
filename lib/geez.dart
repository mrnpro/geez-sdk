/// The `geez` library provides utility extensions and functions for working with Geez numbers.
///
/// Geez is the script used for writing the Ge'ez language, which is an ancient South Semitic
/// language that is still used liturgically by the Ethiopian Orthodox Tewahedo Church and
/// Eritrean Orthodox Tewahdo Church. The Geez script has its own numeric system.
///
/// This library exports two main components:
/// - [GeezToNumberConvertor]: A class that provides a utility method to convert Geez numbers to
///   their corresponding numeric values.
/// - [NumberToGeezConvertor]: An extension on `int` objects that allows converting numbers to
///   Geez numbers represented as strings.
///
/// Example usage:
/// ```dart
/// import 'geez/geez.dart';
///
/// void main() {
///   // Convert Geez numbers to their numeric values
///   int numericValue ='፪፻'.toArabic(); // Converts to 200
///
///   // Convert numbers to Geez numbers
///   int number = 200;
///   String geezNumber = number.toGeez(); // Converts to '፪፻'
/// }
/// ```
///

library geez;

export './src/geez_to_number.dart';
export './src/number_to_geez.dart';
