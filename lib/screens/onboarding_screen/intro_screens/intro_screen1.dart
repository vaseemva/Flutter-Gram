import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/constants.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(180),
                ),
                child: Container(
                  height: size.height * 0.5,
                  color: Colors.blue,
                ),
              ),
              Positioned(
                left: 65,
                bottom: 5,
                top: 55,
                child: SizedBox(
                    width: size.width * 0.75,
                    height: size.height * 0.75,
                    child: Image.asset('assets/images/intro_1.png')),
              ),
            ]
          ),
           kHeight100,
              Text('Collaborate, Learn and Create - the ultimate Flutter developer experience'),
              Text('Discover the newest trends and techniques in Flutter development')
            
        ],
      ),
    );
  }
}
