import '../note/class.dart';

var i1 = Interval(1);
var i2 = Interval(2);
var i3 = Interval(3);
var i4 = Interval(4);
var i5 = Interval(5);
var i6 = Interval(6);
var i7 = Interval(7);
var i8 = Interval(8);
var i9 = Interval(9);
var i10 = Interval(10);
var i11 = Interval(11);
var i12 = Interval(12);
var i13 = Interval(13);
var i14 = Interval(14);
var i15 = Interval(15);
var i16 = Interval(16);

class Interval {
  int step;

  Interval(int interval) {
    if (interval > 0 && interval <= 16) {
      step = interval;
    } else {
      print('invalid interval specified');
    }
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is Interval &&
            step == other.step;

  @override
  int get hashCode => step.hashCode;
}

/// the intervals 1-16 of a scale, run the given function.
void forAllIn(Map<Interval, dynamic> setIntervals, Function(Class) callback) {
  for (var i = 1; i < intervalOrder.length; i++) {
    var testInterval = Interval(i);
    if (setIntervals.containsKey(testInterval)) {
      var c = setIntervals[testInterval];
      callback(c);
    }
  }
}

/// Order of all the intervals, e.g. for stepping from the root of a scale outward to its other tones.
var intervalOrder = <Interval>[
  i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16
];