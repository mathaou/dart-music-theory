// Note can be the Root of a Chord, Key or Scale.
import '../utility/utility.dart';
import 'note.dart';
import 'class.dart';

/// Parse all forms using Regexp's against a string
Tuple<Class, String> rootAndRemaining(String name) =>
  Tuple<Class, String>(item1: classNamed(name.substring(0,1)), item2: name.substring(1).trim());

/*
PRIVATE - these were used at one point but don't really know why, it didn't
make much sense
 */
final _rgxSingle = RegExp(r'^[ABCDEFG]');
final _rgxDouble = RegExp(r'^[ABCDEFG][♯#♭b]');