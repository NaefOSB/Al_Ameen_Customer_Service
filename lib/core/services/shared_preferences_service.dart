import 'package:al_ameen_customer_service/model/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences _sharedPrefs;

  factory SharedPreferencesService() => SharedPreferencesService._internal();

  SharedPreferencesService._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String getString(String key) {
    return _sharedPrefs?.getString(key);
  }

  int getInt(String key) {
    return _sharedPrefs?.getInt(key);
  }

  Future<bool> setString(String key, String value) async {
    try {
      await _sharedPrefs.setString(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setInt(String key, int value) async {
    try {
      await _sharedPrefs.setInt(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  UserInfo getUserInfo() {
    try {
      SharedPreferencesService().init();
      String userId = getString('userId') ?? "";
      String userName = getString('userName') ?? "";
      String phoneNumber = getString('phoneNumber') ?? "";
      String roles = getString('roles') ?? "";
      String token = getString('token') ?? "";
      int customerService = getInt('customerService');
      int accounting = getInt('accounting');
      int maintenance = getInt('maintenance');
      int programming = getInt('programming');
      int branchId = getInt('branchId');

      return new UserInfo(
          userId: userId,
          userName: userName,
          phoneNumber: phoneNumber,
          role: roles,
          token: token,
          branchId: branchId,
          customerService: customerService,
          accounting: accounting,
          maintenance: maintenance,
          programming: programming);
    } catch (e) {
      return new UserInfo();
    }
  }

  setUserInfo(userInfo) async {
    try {
      SharedPreferencesService().init();
      setString('userId', userInfo['userId'].toString());
      setString('userName', userInfo['username'].toString());
      setString('phoneNumber', userInfo['phoneNumber'].toString());
      setString('roles', userInfo['roles'][0].toString());
      setString('token', userInfo['token'].toString());
      //  for user rooms
      setInt(
          'customerService', int.parse(userInfo['customerService'].toString()));
      setInt('accounting', int.parse(userInfo['accounting'].toString()));
      setInt('maintenance', int.parse(userInfo['maintenance'].toString()));
      setInt('programming', int.parse(userInfo['programming'].toString()));
      setInt('branchId', int.parse(userInfo['branchId'].toString()));
    } catch (e) {}
  }

  clearUserInfo() async {
    try {
      await init();
      _sharedPrefs.clear();
    } catch (e) {}
  }
}
