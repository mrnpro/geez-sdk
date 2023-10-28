# Geez SDK

The Geez SDK is a powerful software development kit that simplifies the conversion between numeric values and their corresponding Geez script representations. It provides developers with a seamless way to incorporate Geez numeral conversion into their applications, enabling localization and cultural relevance for Geez-speaking communities.

## Features

- Convert numeric values to Geez script representations.
- Convert Geez script representations to numeric values.

## Installation

To use the Geez SDK in your Flutter project, follow these steps:

1. Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  geez: ^0.0.1
```
2. Run the following command to fetch the package:
```bash
flutter pub get
```
3. Import the Geez package in your Dart code:
```dart 
import 'package:geez/geez.dart';
```
## Usage
### Convert a Number to Geez
```dart 
String geezRepresentation = 134.toGeez();
print(geezRepresentation); // Outputs: ፻፴፬
```
### Convert Geez to a Number
```dart 
num number = '፻፴፬'.toArabic();
print(number); // Outputs: 134
```
# Contributions
Contributions to the Geez SDK are welcomed and encouraged! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository.

# Contributors
Thanks to the following people who have contributed to this project:

Natinael Fikadu - [@mrnpro](https://github.com/mrnpro)

Dagim Mesfin - [@DagmMesfin](https://github.com/DagmMesfin)
