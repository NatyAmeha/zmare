import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/artist_controller.dart';
import 'package:zmare/controller/user_controller.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/artist_widget/artist_list.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/loading_progressbar.dart';

import '../utils/ui_helper.dart';

class ArtistSelectionListScreen extends StatelessWidget {
  static const routeName = "/artist_selection";
  ArtistSelectionListScreen({super.key});

  var artistController = Get.put(ArtistController());
  var userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    artistController.getAllArtists();
    return Scaffold(
      appBar: AppBar(title: CustomText("Select 3 or more artists")),
      body: Stack(
        children: [
          Obx(
            () => UIHelper.displayContent(
              showWhen: true,
              exception: artistController.exception,
              isDataLoading: artistController.isDataLoading,
              content: ArtistList(
                artistController.artistList,
                type: ArtistListType.ARTIST_GRID_LIST,
                selectionState: ListSelectionState.MULTI_SELECTION,
              ),
            ),
          ),
          Positioned.fill(
            left: 16,
            right: 16,
            bottom: 16,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton("Complete Registration",
                    buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                    onPressed: () {
                  userController.signupWithPhone(
                      false, artistController.selectedArtistId);
                }),
              ),
            ),
          ),
          Obx(() => LoadingProgressbar(
                loadingState: userController.isDataLoading ||
                    artistController.isDataLoading,
              ))
        ],
      ),
    );
  }
}
