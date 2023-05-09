import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_veriables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: webBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          // ignore: deprecated_member_use
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapped(0),
            icon: SvgPicture.asset(
              _page == 0
                  ? ("assets/icons/home-filled.svg")
                  : ("assets/icons/home-outlined.svg"),
              color: _page == 0 ? primaryColor : secondaryColor,
              height: 30,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(1),
            icon: SvgPicture.asset(
              _page == 1
                  ? ("assets/icons/search-filled.svg")
                  : ("assets/icons/search.svg"),
              color: _page == 1 ? primaryColor : secondaryColor,
              height: 32,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(2),
            icon: SvgPicture.asset(
              "assets/icons/new-post.svg",
              color: _page == 2 ? primaryColor : secondaryColor,
              height: 22,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(3),
            icon: SvgPicture.asset(
              _page == 3
                  ? ("assets/icons/reel-tap.svg")
                  : ("assets/icons/reel.svg"),
              color: _page == 3 ? primaryColor : secondaryColor,
              height: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/messenger.svg',
              // ignore: deprecated_member_use
              color: primaryColor,
              height: 24,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(4),
            icon: const Icon(
              Icons.person,
              color: primaryColor,
              size: 26,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
    );
  }
}
