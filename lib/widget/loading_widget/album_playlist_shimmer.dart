import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zmare/widget/loading_widget/shimmer_container.dart';

class AlbumPlaylistShimmer extends StatelessWidget {
  const AlbumPlaylistShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).backgroundColor,
          highlightColor: Colors.grey[400]!,
          child: Column(
            children: [
              const SizedBox(height: 100),
              ShimmerContainer(width: 180, height: 200),
              const SizedBox(height: 16),
              ShimmerContainer(width: 200, height: 25),
              const SizedBox(height: 8),
              ShimmerContainer(width: 250, height: 30),
              const SizedBox(height: 8),
              ShimmerContainer(width: 190, height: 20),
              const SizedBox(height: 24),
              ListView(
                shrinkWrap: true,
                children: [
                  buildListShimmer(context),
                  buildListShimmer(context),
                  buildListShimmer(context),
                  buildListShimmer(context),
                  buildListShimmer(context),
                  buildListShimmer(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ShimmerContainer(width: 50, height: 50),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(width: 150, height: 25),
                const SizedBox(height: 8),
                ShimmerContainer(width: 250, height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}
