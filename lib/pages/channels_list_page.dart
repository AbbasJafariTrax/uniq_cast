import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  BetterPlayerControlsConfiguration controlsConfiguration =
      BetterPlayerControlsConfiguration();

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
    // if (controller.isVideoInitialized() ?? false) {
    //   controller.pause();
    // }
    controller.videoPlayerController?.pause();
    controller.clearCache();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double statusSize = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: statusSize),
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
                                    if (ref
                                        .read(currentChannelState.state)
                                        .state
                                        .isNotEmpty) {
                                      print("Mahdi: testing");
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

// body: channels.when(
// data: (channels) => ListView.builder(
//   padding: const EdgeInsets.symmetric(
//     vertical: 10,
//     horizontal: 10,
//   ),
//   itemCount: channels.length,
//   itemBuilder: (ctx, index) {
//     return Row(
//       children: [
//         SizedBox(
//           height: deviceSize.height * 0.1,
//           width: deviceSize.width * 0.3,
//           child: FadeInImage(
//             placeholder: AssetImage("assets/images/movie_place.PNG"),
//             image: NetworkImage(
//               "${UrlAPIs.imageUrl}${channels[index].id}.png",
//             ),
//           ),
//         ),
//       ],
//     );
//   },
// ),
// loading: () => myLoader(deviceSize),
// error: (err, stack) => Center(
//   child: Text("$err"),
// ),
// ),

// Expanded(
//   child: ListView.builder(
//     itemCount: items_list.length,
//     itemBuilder: (ctx, index) {
//       dynamic currentItem = items_list[index];
//       return ItemList(title: currentItem[index],);
//     },
//   ),
// )
// Expanded(
//   child: ListView(
//     children: [
//       ListViewItem(),
//       ListViewItem(),
//       ListViewItem(),
//       ListViewItem(),
//       ListViewItem(),
//       ListViewItem(),
//       ListViewItem(),
//       ListViewItem(),
//     ],
//   ),
// ),

// return Row(
//   children: [
//     SizedBox(
//       height: deviceSize.height * 0.1,
//       width: deviceSize.width * 0.3,
//       child: FadeInImage(
//         placeholder:
//             AssetImage("assets/images/movie_place.PNG"),
//         image: NetworkImage(
//           "${UrlAPIs.imageUrl}${channels[index].id}.png",
//         ),
//       ),
//     ),
//   ],
// );

// Container(
//   height: deviceSize.height * 0.6 - statusSize,
//   width: double.infinity,
//   decoration: BoxDecoration(
//     // color: Color(0xFF26292e),
//     color: Colors.red,
//     borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(10),
//       topRight: Radius.circular(10),
//     ),
//   ),
//   // child: Column(children: [
//   //   Padding(
//   //     padding: const EdgeInsets.all(16.0),
//   //     child: Row(
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       children: [
//   //         Icon(
//   //           Icons.close,
//   //           color: Color(0xFFd0d3d8),
//   //         ),
//   //         SizedBox(
//   //           width: 20,
//   //         ),
//   //         Text(
//   //           'Barang & Promo Pilihan',
//   //           maxLines: 1,
//   //           overflow: TextOverflow.ellipsis,
//   //           style:
//   //               TextStyle(color: Color(0xFFd0d3d8), fontSize: 17),
//   //         ),
//   //       ],
//   //     ),
//   //   ),
//   //   channels.when(
//   //     data: (channels) => ListView.builder(
//   //       padding: const EdgeInsets.symmetric(
//   //         vertical: 10,
//   //         horizontal: 10,
//   //       ),
//   //       itemCount: channels.length,
//   //       itemBuilder: (ctx, index) {
//   //         dynamic currentItem = channels[index];
//   //         return ItemList(
//   //           title: currentItem[index],
//   //         );
//   //       },
//   //     ),
//   //     loading: () => myLoader(deviceSize),
//   //     error: (err, stack) => Center(
//   //       child: Text("$err"),
//   //     ),
//   //   ),
//   // ]),
// ),
