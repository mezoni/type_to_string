import "dart:mirrors";
import "package:type_to_string/type_to_string.dart";
import "package:unittest/unittest.dart";

void main() {
  testBriefly();
}

void testBriefly() {
  var library = currentMirrorSystem().isolate.rootLibrary;
  var mirror = library.declarations[#foo];
  var result = mirrorToString(mirror);
  var reason = "mirrorToString()";
  expect(result, "static dynamic foo", reason: reason);

  mirror = library.declarations[#optional];
  result = mirrorToString(mirror);
  reason = "mirrorToString()";
  expect(result, "static bool optional", reason: reason);

  mirror = library.declarations[#INT];
  result = mirrorToString(mirror);
  reason = "mirrorToString()";
  expect(result, "static const int INT", reason: reason);

  mirror = library.declarations[#one];
  result = mirrorToString(mirror);
  reason = "mirrorToString()";
  expect(result, "static final dynamic one", reason: reason);

  mirror = reflectClass(Foo).declarations[#baz];
  result = mirrorToString(mirror);
  reason = "mirrorToString()";
  expect(result, "int baz", reason: reason);
}

var foo;

bool optional;

const int INT = 0;

final one = 1;

abstract class Foo {
  int baz;
}
