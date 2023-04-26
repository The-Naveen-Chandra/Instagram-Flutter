import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/screens.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Center(child: Text('Reels')),
  ProfileScreen(),
];
