part of 'target_operator.dart';

class _GitOperator {
  static List<String> get changedFilesExcludingDeletedFiles {
    log('Getting changed files...');
    return Process.runSync(
      'git',
      [
        'diff',
        '--name-only',
        '--diff-filter=d',
        'main...',
      ],
    ).stdout.split('\n');
  }

  static List<String> get unchangedFiles {
    log('Getting unchanged files...');
    return Process.runSync(
      'git',
      [
        'diff',
        '--name-only',
        '--diff-filter=U',
        'main...',
      ],
    ).stdout.split('\n');
  }
}
