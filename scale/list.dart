import 'dart:convert';

import 'mode.dart';

var scaleModeList = modes.map((e) => e.name).toList();

String toJson(List<String> l) {
  return jsonEncode(scaleModeList);
}