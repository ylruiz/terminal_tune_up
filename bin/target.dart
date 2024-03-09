import 'target_operator.dart';

final List<Target> allTargets = [
  Target.help(),
  Target.clean(),
  Target.start(),
  Target.startWeb(),
  Target.supperPull(),
  Target.pull(),
  Target.getDeps(),
  Target.buildRunner(),
  Target.preCommit(),
  Target.doc(),
  Target.testCoverage(),
  Target.branchTestCoverage(),
  Target.duplicateCode(),
  Target.branchDuplicateCode(),
];

class TargetNames {
  static const help = 'help';
  static const clean = 'clean';
  static const start = 'start';
  static const startWeb = 'start_web';
  static const superPull = 'super_pull';
  static const pull = 'pull';
  static const getDeps = 'get_deps';
  static const buildRunner = 'build_runner';
  static const preCommit = 'pre_commit';
  static const doc = 'doc';
  static const testCoverage = 'test_coverage';
  static const branchTestCoverage = 'branch_test_coverage';
  static const duplicateCode = 'duplicate_code';
  static const branchDuplicateCode = 'branch_duplicate_code';
}

class Target {
  final String name;
  final String desc;
  final void Function() operator;

  Target({
    required this.name,
    required this.desc,
    required this.operator,
  });

  Target.help()
      : this(
          name: TargetNames.help,
          desc: 'Show commands that can be use by terminal_tune_up.',
          operator: TargetOperator.help,
        );

  Target.clean()
      : this(
          name: TargetNames.clean,
          desc: 'Clean environment.',
          operator: TargetOperator.clean,
        );

  Target.start()
      : this(
          name: TargetNames.start,
          desc: 'Start app in dev mode.',
          operator: TargetOperator.start,
        );

  Target.startWeb()
      : this(
          name: TargetNames.startWeb,
          desc: 'Start web app in dev mode on port 8080.',
          operator: TargetOperator.startWeb,
        );

  Target.supperPull()
      : this(
          name: TargetNames.superPull,
          desc: 'Pull latest changes, get dependencies and run build runner.',
          operator: TargetOperator.superPull,
        );

  Target.getDeps()
      : this(
          name: TargetNames.getDeps,
          desc: 'Get dependencies.',
          operator: TargetOperator.getDeps,
        );

  Target.pull()
      : this(
          name: TargetNames.pull,
          desc: 'Pull latest changes.',
          operator: TargetOperator.pull,
        );

  Target.buildRunner()
      : this(
          name: TargetNames.buildRunner,
          desc: 'Generate files with build_runner.',
          operator: TargetOperator.buildRunner,
        );

  Target.preCommit()
      : this(
          name: TargetNames.preCommit,
          desc: 'Format code, run flutter analyze and run tests.',
          operator: TargetOperator.preCommit,
        );

  Target.doc()
      : this(
          name: TargetNames.doc,
          desc: 'Generate documentation.',
          operator: TargetOperator.doc,
        );

  Target.testCoverage()
      : this(
          name: TargetNames.testCoverage,
          desc: 'Generate coverage report for the whole project.',
          operator: TargetOperator.testCoverage,
        );

  Target.branchTestCoverage()
      : this(
          name: TargetNames.branchTestCoverage,
          desc:
              '''Generate coverage report based on the changes made in the current branch.''',
          operator: TargetOperator.branchTestCoverage,
        );

  Target.duplicateCode()
      : this(
          name: TargetNames.duplicateCode,
          desc: 'Generate duplicate code report for the whole project.',
          operator: TargetOperator.duplicateCode,
        );

  Target.branchDuplicateCode()
      : this(
          name: TargetNames.branchDuplicateCode,
          desc:
              '''Generate duplicate code report based on the changes made in the current branch.''',
          operator: TargetOperator.branchDuplicateCode,
        );

  factory Target.get(String arg) {
    switch (arg) {
      case TargetNames.help:
        return Target.help();
      case TargetNames.clean:
        return Target.clean();
      case TargetNames.start:
        return Target.start();
      case TargetNames.startWeb:
        return Target.startWeb();
      case TargetNames.superPull:
        return Target.supperPull();
      case TargetNames.pull:
        return Target.pull();
      case TargetNames.getDeps:
        return Target.getDeps();
      case TargetNames.buildRunner:
        return Target.buildRunner();
      case TargetNames.preCommit:
        return Target.preCommit();
      case TargetNames.doc:
        return Target.doc();
      case TargetNames.testCoverage:
        return Target.testCoverage();
      case TargetNames.branchTestCoverage:
        return Target.branchTestCoverage();
      case TargetNames.duplicateCode:
        return Target.duplicateCode();
      case TargetNames.branchDuplicateCode:
        return Target.branchDuplicateCode();
      default:
        throw ArgumentError('Invalid target: $arg');
    }
  }
}
