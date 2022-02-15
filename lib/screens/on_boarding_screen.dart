import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../export_feature.dart';

class OnBoardingItem {
  final String? image;
  final String? title;
  final String? body;

  OnBoardingItem({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  List<OnBoardingItem> boardingItem = [
    OnBoardingItem(
      image: ImageHelper.pageViewOne,
      title: 'ORDER ONLINE',
      body: 'Make an order sitting on a sofa Pay and choose online ',
    ),
    OnBoardingItem(
      image: ImageHelper.pageViewTow,
      title: 'MOBILE PAYMENTS',
      body:
          'Download our shopping application and buy using your smartphone or laptop',
    ),
    OnBoardingItem(
      image: ImageHelper.pageViewThree,
      title: 'DELIVERY SERVICE',
      body: 'Modern delivering technologies Shipping to the porch of you apartments',
    ),
  ];
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(
            onPressed: () => openNewPage(context, const LoginScreen(),popPreviousPages: true),
            child: const Text('SKIP',style: TextStyle(color: Colors.indigo),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(

              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boardingItem.length - 1) {
                    setState(() {
                      isDone = true;
                    });
                  } else {
                    setState(() {
                      isDone = false;
                    });
                  }
                },
                allowImplicitScrolling: true,
                physics: const BouncingScrollPhysics(),
                itemCount: boardingItem.length,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingItem[index]),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(

              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boardingItem.length,
                  effect: const ExpandingDotsEffect(),
                ),
                const Spacer(
                  flex: 1,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (!isDone) {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.fastLinearToSlowEaseIn);
                    } else {
                      openNewPage(context, const LoginScreen(),popPreviousPages: true);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingItem item) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('${item.image}'),
          ),
          Text(
            '${item.title}',
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          Text(
            '${item.body}',
          ),
          const SizedBox(height: 20.0),
        ],
      );
}
