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
      Map<String, dynamic> decodeRes = (res.data as Response).data;
      SharedPrefs.setToken(decodeRes["jwt"]);
    } else {
      myToastMsg(res.msg, Colors.red, Colors.white);
    }
    return res.success;
  } catch (e) {
    myToastMsg("$e", Colors.red, Colors.white);
    return false;
  }
}
