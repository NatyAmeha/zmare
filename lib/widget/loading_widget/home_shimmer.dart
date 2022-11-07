import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/loading_widget/shimmer_container.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: CustomContainer(
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).backgroundColor,
            highlightColor: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                buildHeader(context),
                const SizedBox(height: 24),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    children: [
                      ShimmerContainer(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 150),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      ShimmerContainer(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 150),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      ShimmerContainer(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 150),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                buildHeader(context),
                const SizedBox(height: 24),
                Container(
                  height: 110,
                  child: ListView(
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    children: [
                      ShimmerContainer(radius: 55, width: 110, height: 110),
                      const SizedBox(width: 16),
                      ShimmerContainer(radius: 55, width: 110, height: 110),
                      SizedBox(width: 16),
                      ShimmerContainer(radius: 55, width: 110, height: 10),
                      SizedBox(width: 16),
                      ShimmerContainer(radius: 55, width: 110, height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                buildHeader(context),
                const SizedBox(height: 24),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 0),
                  children: [
                    buildProductGridShimmer(context),
                    buildProductGridShimmer(context),
                    buildProductGridShimmer(context),
                    buildProductGridShimmer(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerContainer(width: 200, height: 35),
            const SizedBox(height: 8),
            ShimmerContainer(width: 300, height: 20)
          ],
        ),
        ShimmerContainer(width: 45, height: 45)
      ],
    );
  }

  Widget buildProductGridShimmer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerContainer(width: double.infinity, height: 200),
        const SizedBox(height: 8),
        ShimmerContainer(width: 150, height: 26),
        const SizedBox(height: 8),
        ShimmerContainer(width: 120, height: 20)
      ],
    );
  }
}
