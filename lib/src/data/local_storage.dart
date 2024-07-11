import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tags/src/core/enum/role.dart';

class LocalData {
  factory LocalData() => instance;
  LocalData._internal();
  static final LocalData instance = LocalData._internal();

  late SharedPreferences prefs;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      // Handle property access (getter)
      final propertyName = invocation.memberName
          .toString()
          .substring(8); // Remove 'get: ' prefix
      return prefs.get(propertyName);
    } else if (invocation.isSetter) {
      // Handle property assignment (setter)
      final propertyName = invocation.memberName
          .toString()
          .substring(8); // Remove 'set: ' prefix
      prefs.setString(propertyName, invocation.positionalArguments[0]);
    }
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> removeToken() async {
    await prefs.remove('token');
  }

  Future<void> setToken(String token) async {
    await prefs.setString('token', token);
  }

  String? get token => prefs.getString('token');

  Future<void> setUser(String user) async {
    await prefs.setString('user', user);
  }

  String? get user => prefs.getString('user');

  // bool get clockedIn => prefs.getBool('clockedIn') ?? false;

  // set clockedIn(bool clockedIn) {
  //   prefs.setBool('clockedIn', clockedIn);
  // }

  // set store(InitiativeStore? store) {
  //   if (store == null) {
  //     prefs.remove('clockedinstore');
  //   } else {
  //     prefs.setString('clockedinstore', json.encode(store.toJson()));
  //   }
  // }

  // InitiativeStore? get store {
  //   final store = prefs.getString('clockedinstore');
  //   if (store == null) return null;
  //   return InitiativeStore.fromJson(json.decode(store));
  // }

  // set clockOutTime(DateTime? time) {
  //   if (time == null) {
  //     prefs.remove('clockOutTime');
  //   } else {
  //     prefs.setString('clockOutTime', time.toIso8601String());
  //   }
  // }

  // DateTime? get clockOutTime {
  //   final time = prefs.getString('clockOutTime');
  //   if (time == null) return null;
  //   return DateTime.parse(time);
  // }

  Future<void> setRole(Role role) async {
    await prefs.setString('role', role.value);
  }

  Role? get role {
    final role = prefs.getString('role');
    if (role == null) {
      return null;
    }
    return Role.fromString(role);
  }

  bool get hasToken => prefs.containsKey('token');

  Future<void> setOnboarded(bool isOnboarded) async {
    await prefs.setBool('isOnboarded', isOnboarded);
  }

  bool get isOnboarded => prefs.getBool('isOnboarded') ?? false;

  Future<bool> logOut() async =>
      await prefs.remove('role') && await prefs.remove('token');
}
