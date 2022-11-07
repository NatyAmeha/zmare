import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/viewmodels/artist_viewmodel.dart';
import 'package:zmare/widget/circle_tile.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';

class ArtistStatScreen extends StatelessWidget {
  static const routeName = "/artist_stat";

  ArtistViewmodel artistInfo;
  ArtistStatScreen({required this.artistInfo});

  String get rankText {
    if (artistInfo.rank == 1)
      return "1st this month";
    else if (artistInfo.rank == 2)
      return "2nd this month";
    else if (artistInfo.rank == 3)
      return "3rd this month";
    else
      return "${artistInfo.rank} this. month";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomContainer(
          child: Column(
            children: [
              const SizedBox(height: 100),
              CircleAvatar(
                backgroundImage:
                    NetworkImage(artistInfo.artist!.profileImagePath!.first),
                radius: 60,
              ),
              const SizedBox(height: 26),
              CustomText(artistInfo.artist?.name ?? "",
                  fontSize: 22, fontWeight: FontWeight.bold),
              const SizedBox(height: 32),
              buildStatItem(Icons.star_border_purple500, "This month Rank",
                  artistInfo.rank?.toString()),
              buildStatItem(Icons.group, "Total followers",
                  artistInfo.artist?.followersCount?.toString()),
              buildStatItem(Icons.stream, "Monthly stream",
                  artistInfo.artist?.monthlyStreamCount?.toString()),
              buildStatItem(Icons.stream, "Total stream",
                  artistInfo.artist?.totalStreamCount?.toString()),
              buildStatItem(Icons.audio_file, "Single songs",
                  artistInfo.artist?.singleSongs?.length.toString()),
              buildStatItem(Icons.album, "Albums",
                  artistInfo.artist?.albums?.length.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatItem(IconData icon, String title, String? body) {
    return ListTile(
      onTap: () {},
      leading: Icon(icon),
      title: CustomText(title, fontSize: 16, fontWeight: FontWeight.bold),
      trailing: CustomText(body ?? ""),
    );
  }
}
