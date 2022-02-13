import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniq_cast_test/General/my_shared_prefs.dart';
import 'package:uniq_cast_test/Pages/login_page.dart';
import 'package:uniq_cast_test/general/constants.dart';
import 'package:uniq_cast_test/general/my_loader.dart';
import 'package:uniq_cast_test/general/my_toast_msg.dart';
import 'package:uniq_cast_test/models/channel_model.dart';
import 'package:uniq_cast_test/statemanagement/channel_manager.dart';
import 'package:uniq_cast_test/widgets/ItemList.dart';

const String tvUrlKey = "url_key";
const String tvNameKey = "name_key";

class ChannelsListPage extends StatefulWidget {
  static const routeName = "channels_list_page";

  @override
  State<ChannelsListPage> createState() => _ChannelsListPageState();
}

class _ChannelsListPageState extends State<ChannelsListPage> {
  static BetterPlayerConfiguration betterPlayerConfiguration =
      const BetterPlayerConfiguration(
    autoDispose: true,
    aspectRatio: 16 / 9,
  );
  BetterPlayerController controller = BetterPlayerController(
    betterPlayerConfiguration,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void disposeCurrentVideo() {
    /// Dispose the video controller after closing the video
    controller.videoPlayerController?.pause();
    controller.clearCache();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        title: const Text("Channels"),
        elevation: 10,
        leading: Row(
          children: [
            SizedBox(width: deviceSize.width * 0.03),
            InkWell(
              child: const Icon(Icons.arrow_back_outlined),
              onTap: () {
                SharedPrefs.clearToken().then((value) {
                  if (value) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginPage.routeName,
                      (Route<dynamic> route) => false,
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref.watch(currentChannelState.state).state.isEmpty
                  ? const SizedBox.shrink()
                  : BetterPlayer.network(
                      ref.watch(currentChannelState.state).state[tvUrlKey] ??
                          "",
                      betterPlayerConfiguration: betterPlayerConfiguration,
                    );
            },
          ),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            /// Top corner radius for the list
            double cornerRadius =
                ref.watch(currentChannelState.state).state.isEmpty ? 0 : 10;

            ///To get list of channels from API
            AsyncValue<List<ChannelModel>> channels =
                ref.watch(channelStateFuture);

            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ConstantColor.tvListBG,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cornerRadius),
                    topRight: Radius.circular(cornerRadius),
                  ),
                ),
                child: Column(children: [
                  ref.watch(currentChannelState.state).state.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child: const Icon(
                                  Icons.close,
                                  color: ConstantColor.currentChannelColor,
                                ),
                                onTap: () {
                                  /// Clear the currentChannelState map after closing video
                                  if (ref
                                      .watch(currentChannelState.state)
                                      .state
                                      .isNotEmpty) {
                                    ref
                                        .read(currentChannelState.state)
                                        .state =
                                    {};
                                    disposeCurrentVideo();
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                ref
                                        .watch(currentChannelState.state)
                                        .state[tvNameKey] ??
                                    "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: ConstantColor.currentChannelColor,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                  Expanded(
                    child: channels.when(
                      data: (channels) => channels.isEmpty
                          ? const Center(
                              child: Text("No channel available"),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              itemCount: channels.length,
                              itemBuilder: (ctx, index) {
                                ChannelModel currentItem = channels[index];

                                return InkWell(
                                  child: ItemList(
                                    title: currentItem.name,
                                    channelId: currentItem.id,
                                    isAvailable: currentItem.url != "",
                                  ),
                                  onTap: () {
                                    /// Clear the currentChannelState map playing another video
                                    if (ref
                                        .watch(currentChannelState.state)
                                        .state
                                        .isNotEmpty) {
                                      ref
                                          .read(currentChannelState.state)
                                          .state = {};
                                      disposeCurrentVideo();
                                    }

                                    if (currentItem.url != "") {
                                      ref
                                          .read(currentChannelState.state)
                                          .state = {
                                        tvNameKey: currentItem.name,
                                        tvUrlKey: currentItem.url,
                                      };
                                    } else {
                                      myToastMsg(
                                        "The channel is not available",
                                        Colors.red,
                                        Colors.white,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                      loading: () => myLoader(deviceSize),
                      error: (err, stack) => Center(
                        child: Text("$err"),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          })
        ],
      ),
    );
  }
}
