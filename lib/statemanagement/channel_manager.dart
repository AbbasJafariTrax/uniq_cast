import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniq_cast_test/models/channel_model.dart';
import 'package:uniq_cast_test/network_utils/get_channels.dart';

final channelStateFuture = FutureProvider<List<ChannelModel>>((ref) async {
  return fetchChannels();
});

final currentChannelState = StateProvider((ref) => {});
