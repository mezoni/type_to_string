import "dart:mirrors";
import "package:type_to_string/type_to_string.dart";
import "package:unittest/unittest.dart";

void main() {
  testBriefly();
}

void testBriefly() {
  var mirror = reflectType(new TypeOf<Base<int>>().type);
  var result = mirrorToString(mirror);
  var reason = "mirrorToString()";
  expect(result, "Base<int>", reason: reason);

  mirror = mirror.originalDeclaration;
  result = mirrorToString(mirror);
  expect(result, "Base<B extends num>", reason: reason);

  mirror = reflectType(new TypeOf<Child<double>>().type);
  result = mirrorToString(mirror);
  expect(result, "Child<double>", reason: reason);

  mirror = mirror.originalDeclaration;
  result = mirrorToString(mirror);
  expect(result, "Child<A extends double>", reason: reason);
}

abstract class Base<B extends num> {
}

class Child<A extends double> extends Base<A> {
}

class TypeOf<T> {
  const TypeOf();

  Type get type => T;
}
