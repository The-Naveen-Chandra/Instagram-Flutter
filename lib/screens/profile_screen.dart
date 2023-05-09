import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/screens.dart';
import 'package:instagram_clone/utils/theme.dart';
import 'package:instagram_clone/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: EdgeInsets.symmetric(
              horizontal: width > webScreenSize ? width * 0.33 : 0,
              vertical: width > webScreenSize ? 15 : 0,
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                title: Row(
                  children: [
                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                        ? const Icon(Icons.lock_outline_rounded)
                        : Container(),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      userData['username'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                centerTitle: false,
                actions: [
                  FirebaseAuth.instance.currentUser!.uid == widget.uid
                      ? IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/new-post.svg",
                            // ignore: deprecated_member_use
                            color: primaryColor,
                            height: 24,
                          ),
                        )
                      : Container(),
                  FirebaseAuth.instance.currentUser!.uid == widget.uid
                      ? IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/menu-1.svg",
                            // ignore: deprecated_member_use
                            color: primaryColor,
                            height: 24,
                          ),
                        )
                      : IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                          iconSize: 24,
                        ),
                  const Divider(),
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
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStatColumn(postLen, "Posts"),
                                      buildStatColumn(followers, "Followers"),
                                      buildStatColumn(following, "Following"),
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
                          child: Text(
                            userData['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            userData['bio'],
                            style: const TextStyle(
                              height: 1.3,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: width > webScreenSize
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? FollowButton(
                                    text: "Edit profile",
                                    backgroundColor: Colors.grey.shade900,
                                    textColor: primaryColor,
                                    function: () {},
                                  )
                                : isFollowing
                                    ? FollowButton(
                                        text: "Unfollow",
                                        backgroundColor: Colors.white,
                                        textColor: Colors.black,
                                        function: () async {
                                          await FirestoreMethods().followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid'],
                                          );

                                          setState(() {
                                            isFollowing = false;
                                            followers--;
                                          });
                                        },
                                      )
                                    : FollowButton(
                                        text: "Follow",
                                        backgroundColor: Colors.blue,
                                        textColor: primaryColor,
                                        function: () async {
                                          await FirestoreMethods().followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid'],
                                          );

                                          setState(() {
                                            isFollowing = true;
                                            followers++;
                                          });
                                        },
                                      ),
                            const SizedBox(
                              width: 6,
                            ),
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? FollowButton(
                                    text: "Sign Out",
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    function: () async {
                                      await AuthMethods().signOut();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                  )
                                : FollowButton(
                                    text: "Message",
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
                        FirebaseAuth.instance.currentUser!.uid == widget.uid
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    children: const [
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
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const Divider(),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 1.5,
                                childAspectRatio: 1),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];

                          return Image(
                            image: NetworkImage(
                              snap['postUrl'],
                            ),
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
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
