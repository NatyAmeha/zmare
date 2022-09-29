import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/artist_controller.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_button.dart';

class FollowUnfollowArtistBtn extends StatelessWidget {
  String artistId;
  var artistController = Get.find<ArtistController>();

  FollowUnfollowArtistBtn({required this.artistId});

  @override
  Widget build(BuildContext context) {
    artistController.isArtistInFavorite(artistId);
    return Obx(() => artistController.isFollowing.value
        ? CustomButton("Unfollow", buttonType: ButtonType.ROUND_OUTLINED_BUTTON,
            onPressed: () {
            artistController.unfollowArtist(artistId);
          })
        : CustomButton("Follow", buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
            onPressed: () {
            artistController.followArtist(artistId);
          }));
  }
}