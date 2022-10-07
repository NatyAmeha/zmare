import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_text.dart';

class DownloadStatusIndicator extends StatelessWidget {
  DownloadStatus status;
  double progress;
  double size;
  DownloadStatusIndicator(
      {this.progress = 0,
      this.status = DownloadStatus.NOT_STARTED,
      this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (status == DownloadStatus.NOT_STARTED)
          const Icon(Icons.download, color: Colors.blue),
        if (status == DownloadStatus.COMPLETED)
          const Icon(Icons.download_done_sharp, color: Colors.blue),
        if (status == DownloadStatus.PAUSED)
          const Icon(Icons.pause, color: Colors.blue),
        if (status == DownloadStatus.IN_PROGRESS)
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator.adaptive(
              value: progress,
              strokeWidth: 3,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        const SizedBox(width: 8),
        if (status == DownloadStatus.COMPLETED)
          CustomText("completed", fontSize: 11),
        if (status == DownloadStatus.PAUSED) CustomText("Paused", fontSize: 11),
        if (status == DownloadStatus.IN_PROGRESS)
          CustomText("${progress * 100}%", fontSize: 11),
      ],
    );
  }
}
