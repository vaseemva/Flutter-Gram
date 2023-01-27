import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/onboarding_screen/intro_screens/intro_screen1.dart';
import 'package:flutter_gram/screens/onboarding_screen/intro_screens/intro_screen2.dart';
import 'package:flutter_gram/screens/onboarding_screen/intro_screens/intro_screen3.dart';
import 'package:flutter_gram/screens/onboarding_screen/widgets/intro_button.dart';
import 'package:flutter_gram/screens/sign_in_screen/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  //checking if the user is on the last page
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                //now the user is on the last page
                onLastPage = (index == 2);
              });
            },
            children: getPages,
          ),
          Container(
              alignment: const Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip button
                  IntroButton(
                    ontap: () {
                      _controller.jumpToPage(2);
                    },
                    buttonText: 'skip',
                  ),
                  //page indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: Colors.blue
                    ),
                  ),

                  //next button
                  onLastPage
                      ? IntroButton(ontap: () {
                        setpreferences();
                        navigateToSignin(context);
                      }, buttonText: 'done')
                      : IntroButton(
                          ontap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          buttonText: 'next')
                ],
              ))
        ],
      ),
    );
  }

  List<Widget> get getPages =>
      const [IntroScreen1(), IntroScreen2(), IntroScreen3()];
      navigateToSignin(BuildContext context){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SigninScreen(),));
      }
      setpreferences()async{
        final preferences= await SharedPreferences.getInstance();
        preferences.setBool('introWatched', true);

      }
}
