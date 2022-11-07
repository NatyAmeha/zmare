import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/preview.dart';
import 'package:zmare/repo/shared_pref_repo.dart';
import 'package:zmare/screens/preview/preview_onboarding_page.dart';
import 'package:zmare/service/player/player_service.dart';
import 'package:zmare/usecase/share_usecase.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/extension.dart';
import 'package:zmare/utils/ui_helper.dart';

class PreviewController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = false.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  List<Preview>? previewList;

  IPlayer previewPlayer = JustAudioPlayer();

  onInit() async {
    var sharePref = const SharedPreferenceRepository();
    var showONboarding =
        await sharePref.get<bool>(Constants.SHOW_PREIVEW_ONBOARDING) ?? false;
    if (!showONboarding) {
      UIHelper.moveToScreen(PreviewOnboardingPage.routeName,
          navigatorId: UIHelper.bottomNavigatorKeyId);
      sharePref.create<bool, bool>(Constants.SHOW_PREIVEW_ONBOARDING, true);
    }

    super.onInit();
  }

  Future<void> getPreviews() async {
    try {
      _isDataLoading(true);
      await Future.delayed(const Duration(seconds: 4), () {
        var previews = [
          Preview(
            id: "preivew1",
            title: "Bereket Tesfaye new release",
            description: "Berekt tesfaye new single song preview",
            artistId: "60e18845da21c5137e465fbd",
            artistName: "Bereket Tesfaye",
            audioFile:
                "https://s3.amazonaws.com/storage.input.bucket/music/13ba2f57-155d-4d39-ab7f-8d847e5d5cb9.mp3",
            images: [
              "https://s3.amazonaws.com/storage.output.bucket/images/a60314c4-9816-47ac-9dea-5b312c990d1b.jpg"
            ],
            destinationId: "60d443004708650e29f4c1c3",
            artistImage:
                "https://s3.amazonaws.com/storage.output.bucket/images/4aa003a8-1125-41a3-8b61-4abfcf1990e9.jpg",
          ),
          Preview(
            id: "Rophnan new Album release",
            title: "title 2",
            description: "New albums release preview",
            artistName: "Rophnan",
            audioFile:
                "https://s3.amazonaws.com/storage.input.bucket/music/bf67bef5-9672-43a2-ab7a-56d03f957bae.mp3",
            images: [
              "https://s3.amazonaws.com/storage.output.bucket/images/8db86d2c-7bf0-46ee-8918-2a6dc4c0a62d.jpg"
            ],
            artistId: "60d049e1be4655117091203c",
            destinationId: "60d443004708650e29f4c1c3",
            artistImage:
                "https://s3.amazonaws.com/storage.output.bucket/images/0fdb1c46-7fb5-49ea-939c-d48112d72772.jpg",
          ),
          Preview(
            id: "preivew3",
            title: "Hana tekle new Album preview",
            description: "Hana tekle new Album preview. all 15 songs",
            artistName: "Hana Tekle",
            audioFile:
                "https://s3.amazonaws.com/storage.input.bucket/music/1366e8fc-a0cb-45a8-917c-8facfec9f66f.mp3",
            artistId: "60d560564708650e29f4c1e9",
            images: [
              "https://s3.amazonaws.com/storage.output.bucket/images/6152c9e9-6a61-4a08-ab36-32959fd381ec.jpg"
            ],
            destinationId: "60d56c884708650e29f4c1ea",
            artistImage:
                "https://s3.amazonaws.com/storage.output.bucket/images/e87d0b42-d38a-44ce-ac0b-d07d4e6761fa.jpg",
          ),
          Preview(
            id: "preview4",
            title: "",
            description:
                "Daniel Amdemikael's new and old single and album songs playlist",
            artistName: "Daniel Amdemikael",
            audioFile:
                "https://s3.amazonaws.com/storage.input.bucket/music/6585e9b4-2660-4508-af01-97ca3fc6de72.mp3",
            images: [
              "https://s3.amazonaws.com/storage.output.bucket/images/12c5a442-9ab3-450f-9a85-75386c3ef3ac.jpg"
            ],
            artistId: "60d4b7f84708650e29f4c1d6",
            destinationId: "60d4c2f94708650e29f4c1d8",
            artistImage:
                "https://s3.amazonaws.com/storage.output.bucket/images/5d18ee60-0b2c-4047-8d0b-823c28f9582c.jpg",
          )
        ];
        previewList = previews;
        _isDataLoading(false);
        initPreviewPlayer(previews);
      });
    } catch (ex) {
      _exception(ex as AppException);
    }
  }

  initPreviewPlayer(List<Preview> previews) async {
    if (appController.player.loadedSongs.isNotEmpty) {
      appController.player.stop(savetoPreviousQueue: true);
    }
    var songINfo = previews.map((e) => e.toSong()).toList();
    await previewPlayer.load(songINfo);
    previewPlayer.play();
  }

  sharePreview(String subject, String message, String link) async {
    var shareUsecase = ShareUsecase();
    var body = "${message}\n${link}";
    await shareUsecase.share(subject, body);
  }
}
