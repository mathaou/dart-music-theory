/// Chords have different Forms, such as Triad, Seventh, Extended, Added/Omitted, Specific or General.

import '../scale/interval.dart' as scale;

/// Form is identified by positive/negative regular expressions, and then adds/removes pitch classes by interval from the root of the chord.
class Form {
  String name;
  RegExp pos;
  /// maps an interval-from-chord-root to a +/1 semitone adjustment
  Map<scale.Interval, int> add;
  /// maps an interval-from-chord-root to omit
  List<scale.Interval> omit;

  /// MatchString processes the positive/negative regular expressions to determine if this form matches a string.
  bool matchString(String s) {
    return pos == null || pos.hasMatch(s); // way too many extra steps in original
  }
}

/// forms is an ordered set of rules to match, and corresponding chord intervals to setup.
var forms = <Form>[
  // root
  Form()
    ..name = "Basic"
    ..add = <scale.Interval, int>{
      scale.i1: 0, // root
      scale.i3: 4, // major 3rd
      scale.i5: 7, // perfect 5th
    },
  Form()
    ..name = "Nondominant"
    ..pos = RegExp(_nondominantExp)
    ..omit = <scale.Interval>[
      scale.i1 // no root
    ],
  //Triads
  Form()
    ..name = "Major Triad"
    ..pos = RegExp("^$_majorExp([^a-z]|\$)")
    ..add = <scale.Interval, int>{
      scale.i3: 4, // major 3rd
      scale.i5: 7, // perfect 5th
    },
  Form()
    ..name = "Minor Triad"
    ..pos = RegExp("^$_minorExp([^a-z]|\$)")
    ..add = <scale.Interval, int>{
      scale.i3: 3, // minor 3rd
      scale.i5: 7, // perfect 5th
    },
  Form()
    ..name = "Augmented Triad"
    ..pos = RegExp("^$_augmentedExp")
    ..add = <scale.Interval, int>{
      scale.i3: 4, // major 3rd
      scale.i5: 8, // aug 5th
    },
  Form()
    ..name = "Diminished Triad"
    ..pos = RegExp("^$_diminishedExp")
    ..add = <scale.Interval, int>{
      scale.i3: 3, // minor 3rd
      scale.i5: 6, // dim 5th
    },
  Form()
    ..name = "Suspended Triad"
    ..pos = RegExp("^$_suspendedExp")
    ..add = <scale.Interval, int>{
      scale.i4: 5, // major 3rd
      scale.i5: 7, // perfect 5th
    }
    ..omit = <scale.Interval>[
      scale.i3
    ],

  // Fifth

  Form()
    ..name = "Omit Fifth"
    ..pos = RegExp("$_omitExp${_nExp}5")
    ..omit = <scale.Interval>[
      scale.i5
    ],
  Form()
    ..name = "Flat Fifth"
    ..pos = RegExp("^$_flatExp${_nExp}5")
    ..add = <scale.Interval, int>{
      scale.i5: 6, // flat 5th
    },

  // Sixth

  Form()
    ..name = "Add Sixth"
    ..pos = RegExp("6")
    ..add = <scale.Interval, int>{
      scale.i6: 9, // 6th
    },
  Form()
    ..name = "Augmented Sixth"
    ..pos = RegExp("$_augmentedExp${_nExp}6")
    ..add = <scale.Interval, int>{
      scale.i6: 10, // augmented 6th
    },
  Form()
    ..name = "Omit Sixth"
    ..pos = RegExp("$_omitExp${_nExp}6")
    ..omit = <scale.Interval>[
      scale.i6
    ],

  // Seventh

  Form()
    ..name = "Add Seventh"
    ..pos = RegExp("7")
    ..add = <scale.Interval, int>{
      scale.i7: 10 // dom 7th
    },
  Form()
    ..name = "Dominant Seventh"
    ..pos = RegExp("$_dominantExp${_nExp}7")
    ..add = <scale.Interval, int>{
      scale.i7: 10 // dom 7th
    },
  Form()
    ..name = "Major Seventh"
    ..pos = RegExp("$_majorExp${_nExp}7")
    ..add = <scale.Interval, int>{
      scale.i7: 11 // major 7th
    },
  Form()
    ..name = "Minor Seventh"
    ..pos = RegExp("$_minorExp${_nExp}7")
    ..add = <scale.Interval, int>{
      scale.i7: 10 // dom 7th
    },
  Form()
    ..name = "Diminished Seventh"
    ..pos = RegExp("$_diminishedExp${_nExp}7")
    ..add = <scale.Interval, int>{
      scale.i7: 9 // diminished 7th
    },
  Form()
    ..name = "Half Diminished Seventh"
    ..pos = RegExp("$_halfExp$_nExp$_diminishedExp${_nExp}7")
    ..add = <scale.Interval, int>{
      scale.i3: 3, // minor 3rd
      scale.i5: 6,
      scale.i7: 10
    },
  Form()
    ..name = "Diminished Major Seventh"
    ..pos = RegExp("$_diminishedExp$_nExp$_majorExp${_nExp}7")
    ..add = <scale.Interval, int>{
      // TODO - also applies to augmented major/minor 7th
    },
  Form()
    ..name = "Harmonic Seventh"
    ..pos = RegExp("$_harmonicExp${_nExp}7")
    ..add = <scale.Interval, int>{
      scale.i3: 4, // major 3rd
      scale.i5: 7, // perfect 5th
    },
  Form()
    ..name = "Omit Seventh"
    ..pos = RegExp("$_omitExp${_nExp}7")
    ..omit = <scale.Interval>[
      scale.i7
    ],

  // Ninth

  Form()
    ..name = "Add Ninth"
    ..pos = RegExp("9")
    ..add = <scale.Interval, int>{
      scale.i9: 14 // 9th
    },
  Form()
    ..name = "Dominant Ninth"
    ..pos = RegExp("$_dominantExp${_nExp}9")
    ..add = <scale.Interval, int>{
      scale.i7: 10, // minor 7th
      scale.i9: 14 // 9th
    },
  Form()
    ..name = "Major Ninth"
    ..pos = RegExp("$_majorExp${_nExp}9")
    ..add = <scale.Interval, int>{
      scale.i7: 11, // 9th
      scale.i9: 14 // 9th
    },
  Form()
    ..name = "Minor Ninth"
    ..pos = RegExp("$_minorExp${_nExp}9")
    ..add = <scale.Interval, int>{
      scale.i7: 10, // minor 7th
      scale.i9: 14 // 9th
    },
  Form()
    ..name = "Sharp Ninth"
    ..pos = RegExp("$_sharpExp${_nExp}9")
    ..add = <scale.Interval, int>{
      scale.i9: 15 // sharp 9th
    },
  Form()
    ..name = "Omit Ninth"
    ..pos = RegExp("$_omitExp${_nExp}9")
    ..omit = <scale.Interval>[
      scale.i9
    ],

  // Eleventh

  Form()
    ..name = "Add Eleventh"
    ..pos = RegExp("11")
    ..add = <scale.Interval, int>{
      scale.i11: 17 // 11th
    },
  Form()
    ..name = "Dominant Eleventh"
    ..pos = RegExp("$_dominantExp${_nExp}11")
    ..add = <scale.Interval, int>{
      scale.i7: 10, // minor 7th
      scale.i9: 14, // dom 9th
      scale.i11: 17 // dom 11th
    }
    ..omit = <scale.Interval>[
      scale.i3 // remove clashing minor 9th tone caused by 11th and 3rd
    ],
  Form()
    ..name = "Major Eleventh"
    ..pos = RegExp("$_majorExp${_nExp}11")
    ..add = <scale.Interval, int>{
      scale.i7: 11, // minor 7th
      scale.i9: 14, // dom 9th
      scale.i11: 17 // dom 11th
    },
  Form()
    ..name = "Minor Eleventh"
    ..pos = RegExp("$_minorExp${_nExp}11")
    ..add = <scale.Interval, int>{
      scale.i3: 3, // minor 3rd
      scale.i7: 10, // minor 7th
      scale.i9: 14, // dom 9th
      scale.i11: 17 // dom 11th
    },
  Form()
    ..name = "Omit Eleventh"
    ..pos = RegExp("$_omitExp${_nExp}11")
    ..omit = <scale.Interval>[
      scale.i11
    ],

  // Thirteenth

  Form()
    ..name = "Add Thirteenth"
    ..pos = RegExp("13")
    ..add = <scale.Interval, int>{
      scale.i13: 21 // dom 13th
    },
  Form()
    ..name = "Dominant Thirteenth"
    ..pos = RegExp("$_dominantExp${_nExp}13")
    ..add = <scale.Interval, int>{
      scale.i7: 10, // minor 7th,
      scale.i9: 14, // dom 9th
      scale.i11: 17, // dom 11th
      scale.i13: 21, // dom 13th
    }
    ..omit = <scale.Interval>[
      scale.i3
    ],
  Form()
    ..name = "Major Thirteenth"
    ..pos = RegExp("$_majorExp${_nExp}13")
    ..add = <scale.Interval, int>{
      scale.i3: 4, // major 3rd - music theory nono but w/e
      scale.i7: 11, // minor 7th
      scale.i9: 14, // dom 9th
      scale.i11: 17, // dom 11th
      scale.i13: 21, // dom 13th
    },
  Form()
    ..name = "Minor Thirteenth"
    ..pos = RegExp("$_minorExp${_nExp}13")
    ..add = <scale.Interval, int>{
      scale.i3: 3, // minor 3rd - music theory nono but w/e
      scale.i7: 10, // minor 7th
      scale.i9: 14, // dom 9th
      scale.i11: 17, // dom 11th
      scale.i13: 21, // dom 13th
    },

  // Lydian chords among other things from here
];

/*
PRIVATE
 */

/// Regular expression to use mid-word, gluing together form expression parts
final String _nExp = r'[. ]*';

/// Regular expressions for different utilities
final String _majorExp = r'(M|maj|major)';
final String _minorExp = r'([^a-z]|^)(m|min|minor)';

final String _flatExp  = r'(f|flat|b|♭)';
final String _sharpExp = r'(♯|#|s|sharp)';
final String _halfExp  = r'half';

final String _omitExp = r'(omit|\-)';

final String _dominantExp    = r'(^|dom|dominant)';
final String _nondominantExp = r'(non|nondom|nondominant)';
final String _diminishedExp  = r'(dim|dimin|diminished)';
final String _augmentedExp   = r'(aug|augment|augmented)';
final String _suspendedExp   = r'(sus|susp|suspend|suspended)';
final String _harmonicExp    = r'(harm|harmonic)';