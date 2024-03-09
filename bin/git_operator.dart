part of 'target_operator.dart';

class _GitOperator {
  static List<String> get changedFilesExcludingDeletedFiles {
    log('Getting changed files...');
    final changedFiles = Process.runSync(
      'git',
      [
        'diff',
        '--name-only',
        'main...',
      ],
    ).stdout.split('\n');

    log('Excluding deleted files from changed files...');
    return Process.runSync('git', ['ls-files', ...changedFiles])
        .stdout
        .split('\n')
        .where((file) => !file.startWith('D'))
        .toList();
  }

  static List<String> get unchangedFiles {
    log('Getting unchanged files...');

    final allFiles =
        Process.runSync('git', ['ls-files']).stdout.split('\n').toList();
    final filteredFiles = changedFilesExcludingDeletedFiles;

    return allFiles.where((file) => !filteredFiles.contains(file)).toList();
  }
}
