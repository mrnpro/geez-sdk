import 'dart:io';

String promptUser(String message) {
  stdout.write('$message: ');
  return stdin.readLineSync() ?? '';
}

List<String> getChangelogEntries() {
  final entries = <String>[];
  print('\nEnter changelog entries (one per line).');
  print('Leave empty and press Enter when done.');
  print('Format: type: description');
  print('Types: feat, fix, docs, style, refactor, perf, test, chore');
  print('Example: feat: add new animation controller\n');

  while (true) {
    final entry = promptUser('Entry (or press Enter to finish)');
    if (entry.isEmpty) break;

    // Validate entry format
    if (!entry.contains(':')) {
      print('Invalid format. Please use "type: description"');
      continue;
    }

    final type = entry.split(':')[0].trim();
    final validTypes = [
      'feat',
      'fix',
      'docs',
      'style',
      'refactor',
      'perf',
      'test',
      'chore'
    ];
    if (!validTypes.contains(type)) {
      print('Invalid type. Please use one of: ${validTypes.join(', ')}');
      continue;
    }

    entries.add(entry);
  }
  return entries;
}

void main(List<String> args) {
  if (args.isEmpty) {
    print('Please provide version type: major, minor, or patch');
    exit(1);
  }

  final type = args[0];

  // Get changelog entries first
  print('Please enter the changelog entries for this version.');
  final changelogEntries = getChangelogEntries();

  if (changelogEntries.isEmpty) {
    final proceed =
        promptUser('\nNo changelog entries provided. Proceed anyway? (y/N)');
    if (proceed.toLowerCase() != 'y') {
      print('Version update cancelled.');
      exit(1);
    }
  }

  // Update pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  var pubspecContent = pubspecFile.readAsStringSync();

  // Extract current version
  final versionMatch =
      RegExp(r'version:\s*(\d+)\.(\d+)\.(\d+)').firstMatch(pubspecContent);
  if (versionMatch == null) {
    print('Could not find version in pubspec.yaml');
    exit(1);
  }

  var major = int.parse(versionMatch.group(1)!);
  var minor = int.parse(versionMatch.group(2)!);
  var patch = int.parse(versionMatch.group(3)!);

  // Update version based on type
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

  // Confirm version update
  final confirm = promptUser('\nUpdate to version $newVersion? (y/N)');
  if (confirm.toLowerCase() != 'y') {
    print('Version update cancelled.');
    exit(1);
  }

  // Update pubspec.yaml
  pubspecContent = pubspecContent.replaceFirst(
      RegExp(r'version:\s*\d+\.\d+\.\d+'), 'version: $newVersion');
  pubspecFile.writeAsStringSync(pubspecContent);

  // Update README.md
  final readmeFile = File('README.md');
  if (readmeFile.existsSync()) {
    var readmeContent = readmeFile.readAsStringSync();

    // Update version in installation instructions
    readmeContent = readmeContent.replaceAll(RegExp(r'''dependencies:\s*
  your_package:\s*\^?\d+\.\d+\.\d+'''), '''dependencies:
  your_package: ^$newVersion''');

    // Update version badge if it exists
    readmeContent = readmeContent.replaceAll(
        RegExp(r'pub/v/your_package\)]\(.*?\)'),
        'pub/v/your_package)](https://pub.dev/packages/your_package/versions/$newVersion)');

    readmeFile.writeAsStringSync(readmeContent);
  }

  // Update CHANGELOG.md
  final changelogFile = File('CHANGELOG.md');
  if (changelogFile.existsSync()) {
    var changelogContent = changelogFile.readAsStringSync();
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Organize entries by type
    final organizedEntries = <String, List<String>>{};
    for (final entry in changelogEntries) {
      final type = entry.split(':')[0].trim();
      final description = entry.split(':').sublist(1).join(':').trim();
      organizedEntries.putIfAbsent(type, () => []).add(description);
    }

    // Create formatted changelog entry
    final buffer = StringBuffer();
    buffer.writeln('## $newVersion - $today\n');

    // Order of types
    final typeOrder = [
      'feat',
      'fix',
      'docs',
      'style',
      'refactor',
      'perf',
      'test',
      'chore'
    ];

    // Add entries in ordered format
    for (final type in typeOrder) {
      if (organizedEntries.containsKey(type)) {
        final typeTitle = {
          'feat': 'Features',
          'fix': 'Bug Fixes',
          'docs': 'Documentation',
          'style': 'Styling',
          'refactor': 'Refactoring',
          'perf': 'Performance',
          'test': 'Testing',
          'chore': 'Maintenance'
        }[type];

        buffer.writeln('### $typeTitle');
        for (final description in organizedEntries[type]!) {
          buffer.writeln('* $description');
        }
        buffer.writeln('');
      }
    }

    // Add to existing changelog
    changelogContent = '${buffer.toString()}$changelogContent';
    changelogFile.writeAsStringSync(changelogContent);
  }

  print('\nSuccessfully updated version to $newVersion in:');
  print('- pubspec.yaml');
  print('- README.md');
  print('- CHANGELOG.md');
}
