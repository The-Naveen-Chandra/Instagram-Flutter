import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/follow_button.dart';
import 'package:instagram_clone/widgets/highlight_circle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Row(
          children: const [
            Icon(Icons.lock_outline_rounded),
            SizedBox(
              width: 8,
            ),
            Text(
              'username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/new-post.svg",
              // ignore: deprecated_member_use
              color: primaryColor,
              height: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/menu-1.svg",
              // ignore: deprecated_member_use
              color: primaryColor,
              height: 24,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              top: 16,
              bottom: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1682310934381-ea1437927bd0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNzV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                      ),
                      radius: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(20, "Posts"),
                              buildStatColumn(150, "Followers"),
                              buildStatColumn(10, "Following"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  child: const Text(
                    "Some description...\nBeautiful things don't\nask for attention.",
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 14,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FollowButton(
                      text: "Edit profile",
                      backgroundColor: Colors.grey.shade900,
                      textColor: primaryColor,
                      function: () {},
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    FollowButton(
                      text: "Share profile",
                      backgroundColor: Colors.grey.shade900,
                      textColor: primaryColor,
                      function: () {},
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person_add,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        HighlightCircle(
                          text: "Cars",
                          photoUrl:
                              "https://images.unsplash.com/photo-1682329782353-1f06c794b5b3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                        ),
                        HighlightCircle(
                          text: "💖",
                          photoUrl:
                              "https://images.unsplash.com/photo-1682356828551-96826d14382b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                        ),
                        HighlightCircle(
                          text: "New",
                          isadd: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
