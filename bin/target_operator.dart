import 'dart:developer';
import 'dart:io';

import 'target.dart';

part 'git_operator.dart';
part 'code_quality_report.dart';

class TargetOperator {
  static void help() {
    log('Usage: terminal_tune_up [target]\n');
    log('Targets:\n');

    for (var target in allTargets) {
      log('${target.name}: ${target.desc}\n');
    }

    log(
      '''\n Run "terminal_tune_up [target] --help" to get more information about a specific target.''',
    );
  }

  static void clean() {
    log('Cleaning up...');
    Process.runSync('flutter', ['clean']);
  }

  static void start() {
    log('Starting app in dev mode...');
    Process.runSync('flutter', ['run']);
  }

  static void startWeb() {
    log('Starting web app in dev mode on port 8080...');
    Process.runSync('flutter', ['run', '--web-port=8080']);
  }

  static void superPull() {
    pull();
    getDeps();
    buildRunner();
  }

  static void pull() {
    log('Pulling latest changes...');
    Process.runSync('git', ['pull']);
  }

  static void getDeps() {
    log('Getting dependencies...');
    Process.runSync('flutter', ['pub', 'get']);
    Process.runSync('dart', ['pub', 'outdated', '--no-show-all']);
  }

  static void buildRunner() {
    log('Generating files with build_runner');
    Process.runSync(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    );
  }

  static void preCommit() {
    log('Formatting code...');
    Process.runSync('dart', ['format', '.']);

    log('Running flutter analyze...');
    Process.runSync('flutter', ['analyze']);

    log('Running tests...');
    Process.runSync('flutter', ['test']);
  }

  static void doc() {
    log('Generating documentation...');
    Process.runSync('dartdoc', ['.']);
  }

  static void testCoverage() {
    log('Generating project coverage report...');

    _CodeQualityReport.runTestAndGenerateLcov();
    _CodeQualityReport.removeCodeFromCoverage();
    _CodeQualityReport.generateTestCoverageReport();
  }

  static void branchTestCoverage() {
    log('''Generating coverage report based on the changes made in the current branch...''');
    
    _CodeQualityReport.runTestAndGenerateLcov();
    _CodeQualityReport.removeCodeFromCoverage(
      unchangedFiles: _GitOperator.unchangedFiles,
    );
    _CodeQualityReport.generateTestCoverageReport();
  }

  static void duplicateCode() {
    log('''Generating project duplicate code report''');
    _CodeQualityReport.duplicateCodeReport(
      ['lib'],
      'project_duplicate_code_report',
    );
  }

  static void branchDuplicateCode() {
    log('''Generating current branch duplicate code report''');
    _CodeQualityReport.duplicateCodeReport(
      _GitOperator.changedFilesExcludingDeletedFiles,
      'branch_duplicate_code_report',
    );
  }
}
