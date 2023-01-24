import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/constants.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget(
      {Key? key,
      required this.size,
      required this.image,
      this.radius = const BorderRadius.only(
        bottomLeft: Radius.circular(180),
      ),
      required this.subtitle,
      required this.title,
      required this.leftPosition})
      : super(key: key);

  final Size size;
  final String image;
  final BorderRadius radius;
  final String title;
  final String subtitle;
  final double leftPosition;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          ClipRRect(
            borderRadius: radius,
            child: Container(
              height: size.height * 0.5,
              color: Colors.blue,
            ),
          ),
          Positioned(
            left: leftPosition,
            bottom: 5,
            top: 55,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  image,
                ),
              )),
              width: size.width * 0.75,
              height: size.height * 0.35,
            ),
          ),
        ]),
        kHeight100,
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: size.height * 0.10,
        ),
        Text(subtitle)
      ],
    );
  }
}
