enum Mode {
  Nil,
  Major,
  Minor,
  // others later
}

/// String of the Mode, e.g. "Major" or "Minor"
String string(Mode of) {
  switch(of) {
    case Mode.Nil:
      return "Nil";
    case Mode.Major:
      return "Major";
    case Mode.Minor:
      return "Minor";
  }

  return "";
}

Mode modeOf(String name) {
  if (_rgxMinor.hasMatch(name.trim())) {
    return Mode.Minor;
  } else if (_rgxMajor.hasMatch(name.trim())) {
    return Mode.Major;
  }

  return Mode.Major;
}

/*
PRIVATE
 */

final _rgxMajor = RegExp("(M|maj|major)"); // these used to have a ^ at beginning
final _rgxMinor = RegExp("(m\\b|min|minor|Minor)"); // removed it