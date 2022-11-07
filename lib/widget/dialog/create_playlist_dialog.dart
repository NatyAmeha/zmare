import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/screens/song/song_list_viewpager_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/custom_text_field.dart';

class CreatePlaylistDialog extends StatefulWidget {
  const CreatePlaylistDialog({super.key});

  @override
  State<CreatePlaylistDialog> createState() => _CreatePlaylistDialogState();
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  var textController = TextEditingController();
  bool enableButton = false;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        padding: 24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Create playlist",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: "Playlist name",
              hint: "Enter playlist name",
              controller: textController,
              onchanged: (value) {
                setState(() {
                  enableButton = textController.text.length > 3;
                });
              },
            ),
            CheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                title: CustomText("Make public"),
                value: true,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {}),
            const SizedBox(height: 16),
            CustomButton("Continue",
                icon: Icons.arrow_forward,
                enabled: enableButton,
                buttonType: ButtonType.ROUND_ELEVATED_BUTTON, onPressed: () {
              UIHelper.moveBack();
              UIHelper.moveToScreen(SongListViewpagerScreen.routeName,
                  arguments: {"playlist_name": textController.text});
            })
          ],
        ));
  }
}
