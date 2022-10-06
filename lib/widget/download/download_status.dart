import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_text.dart';

class DownloadStatusIndicator extends StatelessWidget {
  DownloadStatus status;
  double progress;
  DownloadStatusIndicator({
    this.progress = 0,
    this.status = DownloadStatus.NOT_STARTED,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (status == DownloadStatus.NOT_STARTED)
          const Icon(Icons.download, color: Colors.blue),
        if (status == DownloadStatus.COMPLETED)
          const Icon(Icons.download_done_sharp, color: Colors.blue),
        if (status == DownloadStatus.PAUSED)
          const Icon(Icons.pause, color: Colors.blue),
        if (status == DownloadStatus.IN_PROGRESS)
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator.adaptive(
              value: progress,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.center,
          child: CustomText(
            "${progress * 100}%",
            fontSize: 10,
          ),
        ))
      ],
    );
  }
}
