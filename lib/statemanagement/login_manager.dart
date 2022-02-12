import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uniq_cast_test/general/constants.dart';
import 'package:uniq_cast_test/general/my_shared_prefs.dart';
import 'package:uniq_cast_test/general/my_toast_msg.dart';
import 'package:uniq_cast_test/models/api_response.dart';
import 'package:uniq_cast_test/network_utils/network_utils.dart';
import 'package:uniq_cast_test/network_utils/url_apis.dart';
import 'package:uniq_cast_test/pages/channels_list_page.dart';

Future<bool> loginMethod(
    Map<String, String> loginBody, BuildContext context) async {
  try {
    ApiResponse res = await NetworkUtils().post(UrlAPIs.loginUrl, loginBody);

    if (res.success) {
      Map<String, dynamic> decode_res = (res.data as Response).data;
      SharedPrefs.setToken(decode_res["jwt"]);
    } else {
      myToastMsg(res.msg, Colors.red, Colors.white);
    }
    return res.success;
  } catch (e) {
    myToastMsg("$e", Colors.red, Colors.white);
    return false;
  }
}

// Future<List<ChannelModel>> fetchChannels() async {
//   try {
//     ApiResponse response = await NetworkUtils().get(UrlAPIs.channelListUrl);
//
//     if (response.success) {
//       return parseChannels(response.data.data);
//     } else {
//       myToastMsg("Cannot get channels", Colors.red, Colors.white);
//       throw Exception("Cannot get channels");
//     }
//   } catch (e) {
//     throw Exception("Cannot get channels");
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:uniq_cast_test/General/my_shared_prefs.dart';
// import 'package:uniq_cast_test/General/my_toast_msg.dart';
// import 'package:uniq_cast_test/models/api_response.dart';
// import 'package:uniq_cast_test/network_utils/network_utils.dart';
// import 'package:uniq_cast_test/network_utils/url_apis.dart';
//
// class LoginManager with ChangeNotifier {
//   Future<void> login_method(Map<String, String> login_body) async {
//     try {
//       ApiResponse res = await NetworkUtils().post(UrlAPIs.loginUrl, login_body);
//
//       if (res.success) {
//         Map<String, dynamic> decode_res = (res.data as Response).data;
//         SharedPrefs.setToken(decode_res["jwt"]);
//       } else {
//         myToastMsg(res.msg, Colors.red, Colors.white);
//       }
//     } catch (e) {
//       print("Mahdi: login_method: error: $e");
//       print(e);
//     }
//   }
// }
