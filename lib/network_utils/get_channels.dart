import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uniq_cast_test/general/my_toast_msg.dart';
import 'package:uniq_cast_test/models/api_response.dart';
import 'package:uniq_cast_test/models/channel_model.dart';

import 'network_utils.dart';
import 'url_apis.dart';

List<ChannelModel> parseChannels(List<dynamic> responseBody) {
  List<ChannelModel> channels = [];
  responseBody.forEach((element) {
    channels.add(ChannelModel.fromJson(
      element["id"] ?? 0,
      element["name"] ?? "",
      element["url"] ?? "",
      element["lang"] ?? "",
      element["template"] ?? "",
    ));
  });

  return channels;
}

Future<List<ChannelModel>> fetchChannels() async {
  try {
    ApiResponse response = await NetworkUtils().get(UrlAPIs.channelListUrl);

    if (response.success) {
      return parseChannels(response.data.data);
    } else {
      myToastMsg("Cannot get channels", Colors.red, Colors.white);
      throw Exception("Cannot get channels");
    }
  } catch (e) {
    throw Exception("Cannot get channels");
  }
}
