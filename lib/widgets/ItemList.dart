import 'package:flutter/material.dart';
import 'package:uniq_cast_test/general/constants.dart';
import 'package:uniq_cast_test/network_utils/url_apis.dart';

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
