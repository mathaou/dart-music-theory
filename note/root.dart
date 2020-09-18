// Note can be the Root of a Chord, Key or Scale.
import '../utility/utility.dart';
import 'note.dart';
import 'class.dart';

/// Parse all forms using Regexp's against a string
Tuple<Class, String> rootAndRemaining(String name) {
  if (_rgxDouble.hasMatch(name)) {
    return Tuple<Class, String>(item1: classNamed(name.substring(0,2)), item2: name.substring(2).trim());
  }

  if (_rgxSingle.hasMatch(name)) {
    return Tuple<Class, String>(item1: classNamed(name.substring(0,1)), item2: name.substring(1).trim());
  }

  return Tuple<Class, String>(item1: Class.Nil, item2: name.trim());
}

/*
PRIVATE
 */
final _rgxSingle = RegExp(r'^[ABCDEFG]');
final _rgxDouble = RegExp(r'^[ABCDEFG][♯#♭b]');