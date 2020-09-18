import 'class.dart';

/// to another pitch Class calculated in +/- semitonesc
int diff(Class c, Class targetPitch) {
  var diffUp = _classDiff(c, targetPitch, 1);
  var diffDown = _classDiff(c, targetPitch, -1);

  return (diffUp.abs() < diffDown.abs()) ? diffUp : diffDown;
}

/*
PRIVATE
 */

int _classDiff(Class from, Class to, int inc) {
  if (from == null) {
    print("Cannot step semitones from null pitch class");
  }

  var diff = 0;

  while (true) {
    if (from == to) return diff;

    diff += inc;
    var result = step(from, inc);
    from = result?.item1;
  }
}