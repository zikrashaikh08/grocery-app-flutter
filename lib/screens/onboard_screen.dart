import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../constants.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

final _controller = PageController(
  initialPage: 0,
);

int _currentPage = 0;

List<Widget> _pages = [
  Column(
    children: [
      Expanded(child: Image.asset('images/enteraddress.png')),
      const Text(
        'Set Your Delivery Location',
        style: kPageViweTextStyle,
        textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/orderfood.png')),
      const Text(
        'Order Online From Your Favouite Store',
        style: kPageViweTextStyle,
        textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/deliverfood.png')),
      const Text(
        'Quick Deliver To Your Doorstep',
        style: kPageViweTextStyle,
        textAlign: TextAlign.center,
      ),
    ],
  ),
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: newMethod,
    );
  }

  List<Widget> get newMethod {
    return [
      Expanded(
        child: PageView(
          controller: _controller,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      DotsIndicator(
        dotsCount: _pages.length,
        position: _currentPage.toDouble(),
        decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeColor: Theme.of(context).primaryColor),
      ),
      const SizedBox(
        height: 20,
      ),
    ];
  }
}
