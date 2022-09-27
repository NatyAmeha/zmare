import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/viewmodels/download_viewmodel.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/download/download_list_item.dart';
import 'package:zema/widget/download/download_status.dart';

class DownloadScreen extends StatelessWidget {
  static const routName = "/downloads";
  List<DownloadViewmodel>? downloads;

  var downloadList = <DownloadViewmodel>[];
  DownloadScreen({this.downloads}) {
    var images = [
      "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
      "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
      "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
      "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
    ];
    downloadList.addAll([
      DownloadViewmodel(
          title: "Donwloaded songs",
          subtitle: "123 songs",
          images: [...images.toList()]),
      DownloadViewmodel(
          title: "Donwloaded songs",
          subtitle: "123 songs",
          images: [...images.toList()]),
      DownloadViewmodel(
          title: "Donwloaded songs",
          subtitle: "123 songs",
          images: [...images.toList()]),
      DownloadViewmodel(
          title: "Donwloaded songs",
          subtitle: "123 songs",
          images: [...images.toList()]),
      DownloadViewmodel(
          title: "Donwloaded songs",
          subtitle: "123 songs",
          images: [...images.toList()]),
      DownloadViewmodel(
          title: "Donwloaded songs",
          subtitle: "123 songs",
          images: [...images.toList()]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Downloads"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.queue), text: "Songs"),
              Tab(icon: Icon(Icons.album), text: "Albums")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildDownloadList(),
            buildDownloadList(),
          ],
        ),
      ),
    );
  }

  Widget buildDownloadList() {
    return ListView.separated(
      itemCount: downloadList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          DownloadListItem(downloadInfo: downloadList[index]),
    );
  }
}
