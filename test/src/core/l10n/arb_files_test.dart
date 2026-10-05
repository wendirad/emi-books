// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Set<String> _keys(String locale) {
  final Map<String, dynamic> arb =
      jsonDecode(
            File('lib/src/core/l10n/arb/app_$locale.arb').readAsStringSync(),
          )
          as Map<String, dynamic>;
  return arb.keys.where((k) => !k.startsWith('@')).toSet();
}

void main() {
  test('every English string has an Amharic translation and the reverse', () {
    final Set<String> en = _keys('en');
    final Set<String> am = _keys('am');

    expect(en.difference(am), isEmpty, reason: 'missing from app_am.arb');
    expect(am.difference(en), isEmpty, reason: 'missing from app_en.arb');
  });
}
