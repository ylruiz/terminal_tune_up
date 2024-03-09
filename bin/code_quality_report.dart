part of 'target_operator.dart';

class _CodeQualityReport {
  static const _ignoredFiles =
      "**/*.freezed.dart,**/*g.dart,lib/config/**,assets/images/**,.firebase/**";

  //! Duplicate Code Detection
  static void duplicateCodeReport(
    List<String> sourceDir,
    String reportName,
  ) {
    // Check if npm is installed
    ProcessResult result = Process.runSync('npm', ['--version']);

    if (result.exitCode != 0) {
      // If npm is not installed, print error message and exit
      log('Error: npm is not installed.');
      log('Please install Node.js and npm from https://nodejs.org/');
      exit(1);
    } else {
      // Check if jscpd is installed globally
      ProcessResult result = Process.runSync('npm', ['ls', '-g', 'jscpd']);
      String output = result.stdout.toString();

      if (!output.contains('jscpd')) {
        // If not found, install jscpd
        Process.runSync('npm', ['i', '-g', 'jscpd']);
        log('jscpd installed successfully.');
      } else {
        log('jscpd is already installed.');
      }

      Process.runSync('jscpd', [
        ...sourceDir,
        '--reporters',
        'html',
        '--ignore',
        _ignoredFiles,
        '--output',
        reportName,
        '--min-lines',
        '10',
      ]);
    }
  }

  //! Code coverage
  static void runTestAndGenerateLcov() {
    final resultLcov = Process.runSync('lcov', ['--version']);

    if (resultLcov.exitCode != 0) {
      log('Error: lcov is not installed.\n');
      log(
        'Please install LCOV, which includes lcov and genhtml, using one of '
        'the following methods:\n\n'
        '- macOS: Install with Homebrew using the command:\n'
        '  brew install lcov\n\n'
        '- Linux (Ubuntu/Debian): Install with APT using the commands:\n'
        '  sudo apt-get update\n'
        '  sudo apt-get install lcov\n\n'
        '- Linux (Other distributions): Use your package manager to install '
        'lcov. For example, on Fedora:\n'
        '  sudo dnf install lcov\n\n'
        '- Windows: Install with Cygwin or WSL (Windows Subsystem for Linux).'
        '\nFor Cygwin, select the lcov package during installation. For WSL, '
        'install lcov from the Linux distribution available through WSL '
        'using the package manager.\n\n'
        'If you prefer to install lcov manually, you can download the source '
        'code from the official repository and follow the instructions '
        'provided in the README or INSTALL file.',
      );
      exit(1);
    }

    Process.runSync('flutter', ['test', '--coverage']);
  }

  static void removeCodeFromCoverage({List<String>? unchangedFiles}) {
    // Check if remove_from_coverage is installed globally
    ProcessResult result = Process.runSync('dart', ['pub', 'global', 'list']);
    String output = result.stdout.toString();

    if (!output.contains('remove_from_coverage')) {
      // If not found, install remove_from_coverage
      Process.runSync(
        'dart',
        ['pub', 'global', 'activate', 'remove_from_coverage'],
      );
      log('remove_from_coverage installed successfully.');
    }

    log('Removing autogenerated files for test coverage...');

    var args = [
      '-f',
      'coverage/lcov.info',
      '-r',
      r'\.g\.dart$',
    ];

    if (unchangedFiles != null && unchangedFiles.isNotEmpty) {
      args = args.map((file) => '-r $file').toList();
    }

    Process.runSync(
      'remove_from_coverage',
      args,
    );
  }

  static ProcessResult generateTestCoverageReport() {
    final resultGenhtml = Process.runSync('genhtml', ['--version']);

    if (resultGenhtml.exitCode != 0) {
      log('Error: genhtml is not installed.\n');
      log(
        'Please install LCOV, which includes lcov and genhtml, using one of '
        'the following methods:\n\n'
        '- macOS: Install with Homebrew using the command:\n'
        '  brew install lcov\n\n'
        '- Linux (Ubuntu/Debian): Install with APT using the commands:\n'
        '  sudo apt-get update\n'
        '  sudo apt-get install lcov\n\n'
        '- Linux (Other distributions): Use your package manager to install '
        'lcov. For example, on Fedora:\n'
        '  sudo dnf install lcov\n\n'
        '- Windows: Install with Cygwin or WSL (Windows Subsystem for Linux).'
        '\nFor Cygwin, select the lcov package during installation. For WSL, '
        'install lcov from the Linux distribution available through WSL '
        'using the package manager.\n\n'
        'If you prefer to install lcov manually, you can download the source '
        'code from the official repository and follow the instructions '
        'provided in the README or INSTALL file.',
      );
      exit(1);
    }

    return Process.runSync(
      'genhtml',
      ['coverage/lcov.info', '-o', 'coverage/html'],
    );
  }
}
