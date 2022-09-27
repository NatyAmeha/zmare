import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/viewmodels/download_viewmodel.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/image_collection.dart';

class DownloadListItem extends StatelessWidget {
  DownloadViewmodel downloadInfo;
  DownloadListItem({required this.downloadInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minLeadingWidth: 120,
        leading: GridImageCollection(
          downloadInfo.images,
          width: 120,
          height: 120,
        ),
        title: CustomText(downloadInfo.title,
            fontSize: 18, fontWeight: FontWeight.bold),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            CustomText(downloadInfo.subtitle),
            const SizedBox(height: 4),
            CustomText(
              "${downloadInfo.size} mb",
              fontSize: 12,
            )
          ],
        ));
  }
}
