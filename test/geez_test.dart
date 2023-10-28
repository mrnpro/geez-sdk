import 'package:flutter_test/flutter_test.dart';
import 'package:geez/geez.dart';

import 'mock_geez_data.dart';

void main() {
  // Generate a list of numbers from 1 to 1999
  List<int> numbersList = List<int>.generate(1999, (index) => index + 1);

  group(
    'Geez Conversion Tests',
    () => {
      test('Convert a number to Geez - Specific Number #1', () {
        // Convert a specific number to Geez representation
        String geezRepresentation = 134.toGeez();
        expect(geezRepresentation, '፻፴፬');
      }),
      test('Convert a number to Geez - Specific Number #2', () {
        // Convert a specific number to Geez representation
        String geezRepresentation = 1000001.toGeez();
        expect(geezRepresentation, '፻፼፩');
      }),
      test('Convert a number to Geez - Specific Number #3', () {
        // Convert a specific number to Geez representation
        String geezRepresentation = 19876.toGeez();
        expect(geezRepresentation, '፼፺፰፻፸፮');
      }),
      test('Convert a number to Geez - Multiple Numbers', () {
        // Convert multiple numbers to Geez representation
        for (var i = 0; i < numbersList.length; i++) {
          String convertedToGeez = numbersList[i].toGeez();

          expect(convertedToGeez, mockGeezNumbers[i]);
        }
      }),
      test('Convert Geez to Number - Specific Number #1', () {
        // Convert a specific Geez representation to number
        num number = '፻፴፬'.toArabic();
        expect(number, 134);
      }),
      test('Convert Geez to Number - Specific Number #2', () {
        // Convert a specific Geez representation to number
        num number = '፻፼፩'.toArabic();
        expect(number, 1000001);
      }),
      test('Convert Geez to Number - Specific Number #3', () {
        // Convert a specific Geez representation to number
        num number = '፼፺፰፻፸፮'.toArabic();
        expect(number, 19876);
      }),
      test('Convert Geez to Number - Multiple Numbers', () {
        // Convert multiple Geez representations to numbers
        for (var i = 0; i < numbersList.length; i++) {
          num convertedFromGeez = mockGeezNumbers[i].toArabic();
          expect(convertedFromGeez, numbersList[i]);
        }
      }),
    },
  );
}
