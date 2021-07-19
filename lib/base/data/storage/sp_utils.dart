import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// 用来做shared_preferences的存储
class SharePreferenceRepository {
  static SharePreferenceRepository? _instance;

  static Future<SharePreferenceRepository> get instance async {
    return await getInstance();
  }

  static SharedPreferences? _spf;

  SharePreferenceRepository._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SharePreferenceRepository> getInstance() async {
    if (_instance == null) {
      _instance = SharePreferenceRepository._();
      await _instance!._init();
    }
    return _instance!;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set? keys = getKeys();
    return keys!.contains(key);
  }

  Set<String>? getKeys() {
    if (_beforeCheck()) return null;
    return _spf!.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getString(key) ?? '';
  }

  Future<bool>? putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf!.setString(key, value);
  }

  bool? getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getBool(key);
  }

  Future<bool>? putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getInt(key);
  }

  Future<bool>? putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getDouble(key);
  }

  Future<bool>? putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf!.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _spf!.getStringList(key);
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf!.setStringList(key, value);
  }

  Future<bool>? putIntList(String key, List<int> value) {
    if (_beforeCheck()) return null;
    List<String> data = value.map((e) => e.toString()).toList();
    return _spf!.setStringList(key, data);
  }

  List<int>? getIntList(String key) {
    if (_beforeCheck()) return null;
    List<String> data = _spf!.getStringList(key) ?? [];
    List<int> listInt = data.map((e) => int.parse(e)).toList();
    return listInt;
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  Future<bool>? remove(String key) {
    if (_beforeCheck()) return null;
    return _spf!.remove(key);
  }

  Future<bool>? clear() {
    if (_beforeCheck()) return null;
    return _spf!.clear();
  }
}
