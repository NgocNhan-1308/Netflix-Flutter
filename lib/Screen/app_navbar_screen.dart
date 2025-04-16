import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:netflix/Screen/hot_news.dart';
import 'package:netflix/Screen/netflix_home_screen.dart';
import 'package:netflix/Screen/search_screen.dart';

class AppNavbarScreen extends StatelessWidget {
  const AppNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black,
            height: 70,
            child: const TabBar(tabs: [
              Tab(
                icon: Icon(Iconsax.home5),text: 'Home',
              ),
              Tab(
                icon: Icon(Iconsax.search_normal),text: 'search',
              ),
              Tab(
                icon: Icon(Iconsax.gallery), text: 'Hot News',
              )
            ],
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
            ),
          ),
          body: const TabBarView(children: [NetflixHomeScreen(),SearchScreen(),HotNews()],),
        ));
  }
}
