import 'dart:collection';

class TraduoraMapper {
  HashMap<String, String> currentValue;

  TraduoraMapper({this.currentValue});

  String getString(String key) => currentValue[key] ?? "";

}
