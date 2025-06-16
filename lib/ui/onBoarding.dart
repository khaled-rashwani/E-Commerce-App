import 'package:EZ_Shop/ui/User/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Shared/SharedPreferences.dart';
import '../Shared/themes.dart';
import '../main.dart';
import '../shared/helperFunctions.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(
      {required this.image, required this.title, required this.body}) {}
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: './images/onBoarding1.png',
        title: 'Welcome to EZ Shop',
        body: 'We\'re happy to have you here! Explore a world of products from various vendors, all in one place..'),
    BoardingModel(
        image: 'images/search.png',
        title: 'Curated with Care!',
        body: 'Each vendor on our platform has been handpicked to ensure you\'re only presented with the finest products.'),
    BoardingModel(
        image: 'images/Sign_up.png',
        title: 'Simple Registration',
        body: 'Get started by creating an account. It only takes a minute to sign up and unlock a personalized shopping experience.'),
  ];

  bool islast = false;
  void submit() {
    CacheHelper.saveData(key: 'isOnBoardingShowed', value: 1);
   // IsOnBoardingShowed = 1;
    islast = true;
    print('*****************************');
  //  print(IsOnBoardingShowed);
    NavigateAndFinish(context, Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              submit();
            },
            child: Text(
              'skip',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                if (index == boarding.length - 1)
                  setState(() {
                    print('last');
                    islast = true;
                  });
                else {
                  setState(() {
                    print('notlast');
                    islast = false;
                  });
                }
              },
              physics: BouncingScrollPhysics(),
              controller: boardController,
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller: boardController,
                count: boarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                  activeDotColor: primaryColor,
                ),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (islast) {
                    submit();
                  }
                  boardController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ],
      ),
    ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey
                ,fontWeight: FontWeight.w300
            ),
          )
        ],
      );
}
