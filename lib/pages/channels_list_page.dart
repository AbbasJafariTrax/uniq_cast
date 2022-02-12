import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniq_cast_test/general/constants.dart';
import 'package:uniq_cast_test/general/my_loader.dart';
import 'package:uniq_cast_test/general/my_toast_msg.dart';
import 'package:uniq_cast_test/models/channel_model.dart';
import 'package:uniq_cast_test/network_utils/url_apis.dart';
import 'package:uniq_cast_test/statemanagement/channel_manager.dart';

const String tvUrlKey = "url_key";
const String tvNameKey = "name_key";

class ChannelsListPage extends StatelessWidget {
  static const routeName = "channels_list_page";

  BetterPlayerConfiguration betterPlayerConfiguration =
      const BetterPlayerConfiguration(
    autoDispose: false,
    aspectRatio: 16 / 9,
  );

  // Map<String, String> currentTv = {};

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double statusSize = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: statusSize),
          // Consumer(builder: builder)
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(currentChannelState.state).state.isEmpty
                ? const SizedBox.shrink()
                : BetterPlayer.network(
                    ref.watch(currentChannelState.state).state[tvUrlKey] ?? "",
                    betterPlayerConfiguration: betterPlayerConfiguration,
                  );
          }),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: ConstantColor.tvListBG,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(children: [
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return ref.watch(currentChannelState.state).state.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Consumer(
                                  builder: (BuildContext context, WidgetRef ref,
                                      Widget? child) {
                                    return InkWell(
                                      child: const Icon(
                                        Icons.close,
                                        color:
                                            ConstantColor.currentChannelColor,
                                      ),
                                      onTap: () {
                                        if (ref
                                            .watch(currentChannelState.state)
                                            .state
                                            .isNotEmpty) {
                                          ref
                                              .read(currentChannelState.state)
                                              .state = {};
                                        }
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Consumer(
                                  builder: (BuildContext context, WidgetRef ref,
                                      Widget? child) {
                                    return Text(
                                      ref
                                              .watch(currentChannelState.state)
                                              .state[tvNameKey] ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color:
                                            ConstantColor.currentChannelColor,
                                        fontSize: 17,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                  },
                ),
                Consumer(
                  builder: (BuildContext ctx, WidgetRef ref, Widget? child) {
                    AsyncValue<List<ChannelModel>> channels =
                        ref.watch(channelStateFuture);
                    return Expanded(
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

                                  return Consumer(builder:
                                      (BuildContext context, WidgetRef ref,
                                          Widget? child) {
                                    return InkWell(
                                      child: ItemList(
                                        title: currentItem.name,
                                        channelId: currentItem.id,
                                        isAvailable: currentItem.url != "",
                                      ),
                                      onTap: () {
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
                                  });
                                },
                              ),
                        loading: () => myLoader(deviceSize),
                        error: (err, stack) => Center(
                          child: Text("$err"),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
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
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final int channelId;
  final String title;
  final bool isAvailable;

  const ItemList({
    Key? key,
    this.title = "",
    this.isAvailable = false,
    this.channelId = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        bottom: 12,
        left: deviceSize.width * 0.01,
        right: deviceSize.width * 0.01,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Image border
            child: SizedBox(
              height: deviceSize.height * 0.1,
              width: deviceSize.width * 0.3,
              child: !isAvailable
                  ? Image.asset("assets/images/movie_place.PNG")
                  : FadeInImage(
                      placeholder:
                          const AssetImage("assets/images/movie_place.PNG"),
                      image: NetworkImage(
                        "${UrlAPIs.imageUrl}$channelId.png",
                      ),
                    ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title == ""
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: deviceSize.height * 0.02,
                    ),
              title == ""
                  ? const SizedBox.shrink()
                  : Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ConstantColor.titleColorListItem,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              SizedBox(
                height: deviceSize.height * 0.02,
              ),
              Text(
                isAvailable ? "Available" : "Unavailable",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isAvailable ? Colors.green : Colors.red,
                  fontSize: 15,
                ),
              ),
            ],
          ),
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
