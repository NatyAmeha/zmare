import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/category_list.dart';

class AccountScreen extends StatelessWidget {
  static const routName = "/account";

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: CustomText("Account"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {},
              ),
              backgroundColor: Colors.white,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: ListTile(
                  minLeadingWidth: 60,
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
                    ),
                    radius: 30,
                  ),
                  title: CustomText("Natnael Ameha",
                      fontSize: 19, fontWeight: FontWeight.bold),
                  subtitle: CustomText("Manage account", fontSize: 13),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
              children: [
                CategoryListItem(
                  title: "Liked songs",
                  subtitle: "12",
                  icon: Icons.favorite,
                ),
                CategoryListItem(
                  title: "Favorite Albums",
                  subtitle: "8",
                  icon: Icons.album,
                ),
                CategoryListItem(
                  title: "Your plalists",
                  subtitle: "3",
                  icon: Icons.playlist_play,
                ),
                CategoryListItem(
                  title: "Downloads",
                  subtitle: "12",
                  icon: Icons.download,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}