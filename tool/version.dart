import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Please provide version type: major, minor, or patch');
    exit(1);
  }

  final type = args[0];
  final pubspecFile = File('pubspec.yaml');
  var content = pubspecFile.readAsStringSync();

  final versionMatch =
      RegExp(r'version:\s*(\d+)\.(\d+)\.(\d+)').firstMatch(content);
  if (versionMatch == null) {
    print('Could not find version in pubspec.yaml');
    exit(1);
  }

  var major = int.parse(versionMatch.group(1)!);
  var minor = int.parse(versionMatch.group(2)!);
  var patch = int.parse(versionMatch.group(3)!);

  switch (type) {
    case 'major':
      major++;
      minor = 0;
      patch = 0;
      break;
    case 'minor':
      minor++;
      patch = 0;
      break;
    case 'patch':
      patch++;
      break;
    default:
      print('Invalid version type. Use major, minor, or patch');
      exit(1);
  }

  final newVersion = '$major.$minor.$patch';
  content = content.replaceFirst(
      RegExp(r'version:\s*\d+\.\d+\.\d+'), 'version: $newVersion');

  pubspecFile.writeAsStringSync(content);
  print('Updated version to $newVersion');
}
