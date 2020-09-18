import 'interval.dart';

// Regular expression to use mid-word, gluing together mode expression parts
var _nExp = r'[. ]*';

/*
Regular expressions for different utilities
 */
var _majorExp =       r'(M|maj|major)';
var _minorStrictExp = r'([^a-z]|^)(m|min|minor)';
var _minorExp =       r'(m|min|minor)';

var _harmonicExp =    r'(harm|harmonic)';
var _augmentedExp =   r'(aug|augment|augmented)';
var _diminishedExp =  r'(dim|dimin|diminished)';
var _descendExp =     r'(desc|descend)';
var _ascendExp =      r'(asc|ascend)';
var _melodicExp =     r'(mel|melodic)';
var _naturalExp =     r'(nat|natural)';

var _locrianExp =     r'(loc|locrian)';
var _ionianExp =      r'(ion|ionian)';
var _dorianExp =      r'(dor|dorian)';
var _phrygianExp =    r'(phr|phrygian)';
var _lydianExp =      r'(lyd|lydian)';
var _mixolydianExp =  r'(mix|mixolydian)';
var _aeolianExp =     r'(aeo|aeolian)';

/*
Intervals for different modes
 */
var _ionianIntervals =      <int>[2,2,1,2,2,2];
var _dorianIntervals =      <int>[2,1,2,2,2,1];
var _phrygianIntervals =    <int>[1,2,2,2,1,2];
var _lydianIntervals =      <int>[2,2,2,1,2,2];
var _mixolydianIntervals =  <int>[2,2,1,2,2,1];
var _aeolianIntervals =     <int>[2,1,2,2,1,2];
var _locrianIntervals =     <int>[1,2,2,1,2,2];

/// modes is an ordered set of rules to match, and corresponding scale intervals to setup.
var modes = <Mode>[
    Mode()
      ..name = "Default (Major)"
      ..set = _ionianIntervals,
    Mode()
      ..name = "Minor"
      ..pos = RegExp(_minorStrictExp)
      ..set = _aeolianIntervals,
    Mode()
      ..name = "Major"
      ..pos = RegExp(_majorExp)
      ..set = _ionianIntervals,
    Mode()
      ..name = "Natural Minor"
      ..pos = RegExp("$_naturalExp$_nExp$_minorExp")
      ..set = _aeolianIntervals,
    Mode()
      ..name = "Diminished"
      ..pos = RegExp(_diminishedExp)
      ..set = <int>[2,1,2,1,2,1,2],
    Mode()
      ..name = "Augmented"
      ..pos = RegExp(_augmentedExp)
      ..set = <int>[3,1,3,1,3]
      ..omit = <Interval>[i7],
    Mode()
      ..name = "Melodic Minor Ascend"
      ..pos = RegExp("$_melodicExp$_nExp$_minorExp$_nExp$_ascendExp")
      ..set = <int>[2,1,2,2,2,2],
    Mode()
      ..name = "Melodic Minor Descend"
      ..pos = RegExp("$_melodicExp$_nExp$_minorExp$_nExp$_descendExp")
      ..set = <int>[2,1,2,2,1,2],
    Mode()
      ..name = "Harmonic Minor"
      ..pos = RegExp("$_harmonicExp$_nExp$_minorExp")
      ..set = <int>[2,1,2,2,1,3],
    Mode()
      ..name = "Ionian"
      ..pos = RegExp(_ionianExp)
      ..set = _ionianIntervals,
    Mode()
      ..name = "Dorian"
      ..pos = RegExp(_dorianExp)
      ..set = _dorianIntervals,
    Mode()
      ..name = "Phrygian"
      ..pos = RegExp(_phrygianExp)
      ..set = _phrygianIntervals,
    Mode()
      ..name = "Lydian"
      ..pos = RegExp(_lydianExp)
      ..set = _lydianIntervals,
    Mode()
      ..name = "Mixolydian"
      ..pos = RegExp(_mixolydianExp)
      ..set = _mixolydianIntervals,
    Mode()
      ..name = "Aeolian"
      ..pos = RegExp(_aeolianExp)
      ..set = _aeolianIntervals,
    Mode()
      ..name = "Locrian"
      ..pos = RegExp(_locrianExp)
      ..set = _locrianIntervals
];

/// Mode is identified by positive/negative regular expressions, and then adds/removes pitch classes by interval from the root of the scale.
class Mode {
  String name;
  RegExp pos;
  /// maps an interval-from-scale-root to a +/1 semitone adjustment
  List<int> set;
  /// maps an interval-from-scale-root to omit
  List<Interval> omit;

  /// processes the positive/negative regular expressions to determine if this mode matches a string.
  bool matchString(String s) {
    return this._matchPosNegString(s);
  }

  bool _matchPosNegString(String s) {
    if (this.pos == null) {
      return true;
    } else if (this.pos.hasMatch(s)) {
      // original library had some stuff up here but master branch commented
      // it out so I'll just leave this branch even though it could be
      // condensed into the previous case. - M. Farstad 9/7/2020
      return true;
    }

    return false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Mode &&
              name == other.name && pos == other.pos &&
              set == other.set && omit == other.omit;

  @override
  int get hashCode => name.hashCode ^ pos.hashCode ^
          set.hashCode ^ omit.hashCode;
}