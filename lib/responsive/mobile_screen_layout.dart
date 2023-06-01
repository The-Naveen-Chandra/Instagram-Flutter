import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/theme.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
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
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 0
                    ? ("assets/icons/home-filled.svg")
                    : ("assets/icons/home-outlined.svg"),
                color: _page == 0
                    ? Theme.of(context).colorScheme.primary
                    : secondaryColor,
                height: 30,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 1
                    ? ("assets/icons/search-filled.svg")
                    : ("assets/icons/search.svg"),
                color: _page == 1
                    ? Theme.of(context).colorScheme.primary
                    : secondaryColor,
                height: 32,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/new-post.svg",
                color: _page == 2
                    ? Theme.of(context).colorScheme.primary
                    : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 3
                    ? ("assets/icons/reel-tap.svg")
                    : ("assets/icons/reel.svg"),
                color: _page == 3
                    ? Theme.of(context).colorScheme.primary
                    : secondaryColor,
                height: 24,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4
                    ? Theme.of(context).colorScheme.primary
                    : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
          onTap: navigationTapped,
        ),
      ),
    );
  }
}
