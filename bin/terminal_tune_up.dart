import 'dart:developer';

import 'target.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    log('Usage: terminal_tune_up <target>');
    return;
  }

  final target = Target.get(arguments[0]);
  target.operator();
}
