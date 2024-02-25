import 'target_operator.dart';

class Target {
  final String name;
  final String desc;
  final void Function() operator;

  Target({
    required this.name,
    required this.desc,
    required this.operator,
  });

  factory Target.get(String arg) {
    switch (arg) {
      case 'help':
        return Target(
          name: arg,
          desc: 'Show commands that can be use by terminal_tune_up.',
          operator: TargetOperator.help,
        );
      case 'clean':
        return Target(
          name: arg,
          desc: 'Clean environment.',
          operator: TargetOperator.clean,
        );
      case 'start':
        return Target(
          name: arg,
          desc: 'Start app in dev mode.',
          operator: TargetOperator.start,
        );
      case 'start_web':
        return Target(
          name: arg,
          desc: 'Start web app in dev mode on port 8080.',
          operator: TargetOperator.startWeb,
        );
      case 'super_pull':
        return Target(
          name: arg,
          desc: 'Pull latest changes, get dependencies and run build runner.',
          operator: TargetOperator.superPull,
        );
      case 'pull':
        return Target(
          name: arg,
          desc: 'Pull latest changes.',
          operator: TargetOperator.pull,
        );
      case 'get_deps':
        return Target(
          name: arg,
          desc: 'Get dependencies.',
          operator: TargetOperator.getDeps,
        );
      case 'build_runner':
        return Target(
          name: arg,
          desc: 'Generate files with build_runner.',
          operator: TargetOperator.buildRunner,
        );
      case 'pre_commit':
        return Target(
          name: arg,
          desc: 'Format code, run flutter analyze and run tests.',
          operator: TargetOperator.preCommit,
        );
      case 'doc':
        return Target(
          name: arg,
          desc: 'Generate documentation.',
          operator: TargetOperator.doc,
        );
      case 'project_test_coverage':
        return Target(
          name: arg,
          desc: 'Generate coverage report for the whole project.',
          operator: TargetOperator.projectTestCoverage,
        );
      case 'branch_test_coverage':
        return Target(
          name: arg,
          desc:
              '''Generate coverage report based on the changes made in the current branch.''',
          operator: TargetOperator.branchTestCoverage,
        );
      case 'project_duplicate_code':
        return Target(
          name: arg,
          desc: 'Generate duplicate code report for the whole project.',
          operator: TargetOperator.projectDuplicateCode,
        );
      case 'branch_duplicate_code':
        return Target(
          name: arg,
          desc:
              '''Generate duplicate code report based on the changes made in the current branch.''',
          operator: TargetOperator.branchDuplicateCode,
        );
      default:
        throw ArgumentError('Invalid target: $arg');
    }
  }
}
