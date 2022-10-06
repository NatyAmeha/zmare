import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/modals/download.dart';
import 'package:zema/viewmodels/download_viewmodel.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/image_collection.dart';

class DownloadListItem extends StatelessWidget {
  DownloadViewmodel downloadInfo;
  DownloadListItem({required this.downloadInfo});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: 16,
      child: Row(
        children: [
          GridImageCollection(downloadInfo.images, height: 100, width: 100),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(downloadInfo.title,
                  fontSize: 17, fontWeight: FontWeight.bold),
              const SizedBox(height: 8),
              CustomText(downloadInfo.subtitle, fontSize: 15),
              const SizedBox(height: 8),
              CustomText("album", fontSize: 10),
            ],
          )),
          const SizedBox(width: 16),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
    );
  }
}
