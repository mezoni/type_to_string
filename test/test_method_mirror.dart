import "dart:mirrors";
import "package:type_to_string/type_to_string.dart";
import "package:unittest/unittest.dart";

void main() {
  testBriefly();
}

void testBriefly() {
  var mirror = (reflect(foo) as ClosureMirror).function;
  var result = mirrorToString(mirror);
  var reason = "mirrorToString()";
  expect(result, "static foo() => void", reason: reason);

  mirror = (reflect(baz) as ClosureMirror).function;
  result = mirrorToString(mirror);
  expect(result, "static baz(int) => dynamic", reason: reason);

  mirror = (reflect(optional) as ClosureMirror).function;
  result = mirrorToString(mirror);
  expect(result, "static optional(int, int) => bool", reason: reason);

  mirror = (reflect(named) as ClosureMirror).function;
  result = mirrorToString(mirror);
  expect(result, "static named(int, {b: int, c: int}) => bool", reason: reason);

  mirror = reflectClass(Foo).declarations[#Foo];
  result = mirrorToString(mirror);
  expect(result, "Foo() => Foo", reason: reason);

  mirror = reflectClass(Foo).declarations[new Symbol("Foo.from")];
  result = mirrorToString(mirror);
  expect(result, "Foo.from() => Foo", reason: reason);
}

void foo() {
}

baz(int i) {
}

bool optional(int a, int b) {
  return a > b;
}

bool named(int a, {int b, int c}) {
  return a > b;
}

abstract class Foo {
  Foo();

  Foo.from();
}
