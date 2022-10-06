import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/modals/download.dart';
import 'package:zema/viewmodels/download_viewmodel.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/image_collection.dart';

class DownloadListItem extends StatelessWidget {
  Download downloadInfo;
  DownloadListItem({required this.downloadInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minLeadingWidth: 120,
        leading: CustomImage(
          downloadInfo.image,
          width: 50,
          height: 50,
        ),
        // leading: GridImageCollection(
        //   downloadInfo.image,
        //   width: 120,
        //   height: 120,
        // ),
        title: CustomText(downloadInfo.name ?? "",
            fontSize: 18, fontWeight: FontWeight.bold),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            CustomText(downloadInfo.location.toString()),
            const SizedBox(height: 4),
            CustomText(
              "mb",
              fontSize: 12,
            )
          ],
        ));
  }
}
