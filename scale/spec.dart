import 'dart:convert';

import 'scale.dart';
import '../note/class.dart';

String toJson(Scale c) {
  var spec = specFrom(c);
  return jsonEncode({"root": "${spec.root}", "tones": "${spec.tones}"});
}

SpecScale specFrom(Scale c) {
  var s = SpecScale()
      ..root = string(c.root, c.adjSymbol)
      ..tones = Map<int, String>();

  c.tones.forEach((key, value) {
    s.tones[key.step] = string(value, c.adjSymbol);
  });

  return s;
}

class SpecScale {
  String root;
  Map<int, String> tones;
}