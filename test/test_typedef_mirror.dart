import "dart:mirrors";
import "package:type_to_string/type_to_string.dart";
import "package:unittest/unittest.dart";

void main() {
  testBriefly();
}

void testBriefly() {
  var mirror = reflectType(Foo);
  var result = mirrorToString(mirror);
  var reason = "mirrorToString()";
  expect(result, "() => void", reason: reason);

  mirror = reflectType(Baz);
  result = mirrorToString(mirror);
  expect(result, "(int) => dynamic", reason: reason);

  mirror = reflectType(Optional);
  result = mirrorToString(mirror);
  expect(result, "(int, int) => bool", reason: reason);

  mirror = reflectType(Named);
  result = mirrorToString(mirror);
  expect(result, "(int, {b: int, c: int}) => bool", reason: reason);
}

typedef void Foo();

typedef Baz(int i);

typedef bool Optional(int a, int b);

typedef bool Named(int a, {int b, int c});
