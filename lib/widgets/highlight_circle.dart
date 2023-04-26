import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class HighlightCircle extends StatelessWidget {
  final String text;
  final String photoUrl;
  final bool isadd;
  final Function()? function;

  const HighlightCircle({
    super.key,
    this.isadd = false,
    this.function,
    required this.text,
    this.photoUrl = "https://source.unsplash.com/random/200x201",
  });

  @override
  Widget build(BuildContext context) {
    return isadd == false
        ? GestureDetector(
            onTap: function,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: Colors.grey.shade900,
                        width: 3,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: function,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      color: mobileBackgroundColor,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 32,
                      color: primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("New"),
                  ),
                ],
              ),
            ),
          );
  }
}
