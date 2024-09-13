// ignore_for_file: type_annotate_public_apis, unnecessary_await_in_return

import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tags/src/data/hivekeys.dart';

class HiveStorage {
  static final box = Hive.box(HiveKeys.appBox);

  static FutureOr<dynamic> put(key, value) async => await box.put(key, value);

  static dynamic get(String key) => box.get(key);

  static dynamic getAt(int key) => box.getAt(key);

  static Future<int> add(value) async => await box.add(value);

  static Future<int> clear() async => await box.clear();

  static Future<void> delete(value) async => await box.delete(value);

  static Future<void> putAll(Map<String, dynamic> entries) async =>
      await box.putAll(entries);
}
