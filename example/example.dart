import "dart:mirrors";
import "package:type_to_string/type_to_string.dart";

void main() {
  // Print type
  print("========");
  var list = new List<List>();
  var type = list.runtimeType;
  print(type);
  print(typeToString(type));

  // Print method mirror
  print("========");
  var mirror = reflectClass(Foo).declarations[#compare];
  print(mirror);
  print(mirrorToString(mirror));

  // Print typedef
  print("========");
  print(Catch);
  print(typeToString(Catch));
}

typedef void Catch(e, StackTrace st);

abstract class Foo<T extends num> {
  int compare(int a, int b) {
    return a - b;
  }
}
