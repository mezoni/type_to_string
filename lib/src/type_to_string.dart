part of type_to_string;

/**
 * Returns the [String] represenation of the [mirror].
 */
String mirrorToString(Mirror mirror) {
  if (mirror == null) {
    throw new ArgumentError("mirror: $mirror");
  }

  return _ToString._mirror(mirror);
}

/**
 * Returns the [String] represenation of the [type].
 */
String typeToString(Type type) {
  if (type == null) {
    throw new ArgumentError("type: $type");
  }

  return _ToString._mirror(reflectType(type));
}

class _ToString {
  static TypeMirror _dynamicMirror = currentMirrorSystem().dynamicType;

  static TypeMirror _objectMirror = reflectType(Object);

  static String _function(TypeMirror returnType, List<ParameterMirror> parameters) {
    var result = ["("];
    var namedParamters = [];
    var optionalParameters = [];
    var parameterList = [];
    for (var parameter in parameters) {
      var typeName = _typeMirror(parameter.type);
      if (parameter.isNamed) {
        var name = MirrorSystem.getName(parameter.simpleName);
        namedParamters.add("$name: $typeName");
      } else if (parameter.isOptional) {
        optionalParameters.add(typeName);
      } else {
        parameterList.add(typeName);
      }
    }

    if (!optionalParameters.isEmpty) {
      var list = ["["];
      list.add(optionalParameters.join(", "));
      list.add("]");
      parameterList.add(list.join());
    }

    if (!namedParamters.isEmpty) {
      var list = ["{"];
      list.add(namedParamters.join(", "));
      list.add("}");
      parameterList.add(list.join());
    }

    result.add(parameterList.join(", "));
    result.add(") => ${_typeMirror(returnType)}");
    return result.join();
  }

  static String _functionTypeMirror(FunctionTypeMirror mirror) {
    return _function(mirror.returnType, mirror.parameters);
  }

  static String _mirror(Mirror mirror) {
    if (mirror is MethodMirror) {
      return _methodMirror(mirror);
    }

    if (mirror is FunctionTypeMirror) {
      return _functionTypeMirror(mirror);
    }

    if (mirror is ClassMirror) {
      return _typeMirror(mirror);
    }

    if (mirror is TypedefMirror) {
      return _typedefMirror(mirror);
    }

    if (mirror is TypeVariableMirror) {
      return _typeVariableMirror(mirror);
    }

    if (mirror is TypeMirror) {
      return _typeMirror(mirror);
    }

    if (mirror is VariableMirror) {
      return _variableMirror(mirror);
    }

    return mirror.toString();
  }

  static String _methodMirror(MethodMirror mirror) {
    var result = [];
    if (mirror.isStatic) {
      result.add("static ");
    }

    result.add(MirrorSystem.getName(mirror.simpleName));
    result.add(_function(mirror.returnType, mirror.parameters));
    return result.join();
  }

  static String _typedefMirror(TypedefMirror mirror) {
    var referent = mirror.referent;
    return _function(referent.returnType, referent.parameters);
  }

  static String _typeMirror(TypeMirror mirror) {
    var result = [MirrorSystem.getName(mirror.simpleName)];
    var parameters = [];
    if (mirror.isOriginalDeclaration) {
      for (var variable in mirror.typeVariables) {
        parameters.add(_typeVariableMirror(variable));
      }
    } else {
      for (var argument in mirror.typeArguments) {
        parameters.add(_typeMirror(argument));
      }
    }

    if (parameters.length != 0) {
      result.add("<");
      result.add(parameters.join(", "));
      result.add(">");
    }

    return result.join();
  }

  static String _typeVariableMirror(TypeVariableMirror mirror) {
    var name = MirrorSystem.getName(mirror.simpleName);
    var upperBound = mirror.upperBound;
    if (upperBound == _objectMirror) {
      return name;
    }

    return "$name extends ${_typeMirror(upperBound)}";
  }

  static String _variableMirror(VariableMirror mirror) {
    var result = [];
    if (mirror.isStatic) {
      result.add("static ");
    }

    if (mirror.isConst) {
      result.add("const ");
    } else if (mirror.isFinal) {
      result.add("final ");
    }

    result.add(_typeMirror(mirror.type));
    var name = MirrorSystem.getName(mirror.simpleName);
    result.add(" $name");
    return result.join();
  }
}
