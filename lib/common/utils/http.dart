import 'package:device_info/device_info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  static Future get(String url) async {
    try {
      // var userToken = Config.USER_TOKEN;
      // Map<String, String> mapHeaders = {"x-access-token": userToken.toString()};
      // final res = await http.get(url, headers: mapHeaders);
      final res = await http.get(url);
      // String data = gbk.decode(res.bodyBytes);
      return res.bodyBytes;
    } catch (e) {
      print("请求错误-------------------------------------url:$url");
      return null;
    }
  }

  static Future getBody(String url) async {
    try {
      final res = await http.get(url);
      // File cf = new File(
      //     "/Users/joucks/Library/Developer/CoreSimulator/Devices/FDD6A480-A41B-4D73-BFA0-F20A30ECC134/data/Containers/Data/Application/4B57B339-689E-4738-B764-4C973447D97F/Documents/test.json");
      // print("写入地址:${cf.path}");
      // cf.createSync();
      // cf.writeAsStringSync(res.body);
      // print("+=======================${res.body}");
      return res.body;
    } catch (e) {
      print("请求错误-------------------------------------url:$e");
      return null;
    }
  }

  static post(String url, body) async {
    final res = await http.post(url, body: body);
    return {"code": res.statusCode, "errorMessage": res.reasonPhrase};
  }

  static getConfig(String url, type) async {
    try {
      print("初始请求--------");
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      var str = "";
      if (type == 'ios') {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        str += iosInfo.systemVersion + ",";
        str += iosInfo.systemName + ",";
        str += iosInfo.identifierForVendor + ",";
        str += iosInfo.name + ",";
        str += iosInfo.model;
      } else {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        str += androidInfo.version.baseOS;
        str += androidInfo.product;
        str += androidInfo.androidId;
        str += androidInfo.device;
        str += androidInfo.model;
      }
      final res = await http.get("http://localhost:3002/config?info=" + str);
      return res.body;
    } catch (e) {
      print("初始请求报错-------$e");
      return null;
    }
  }
}
