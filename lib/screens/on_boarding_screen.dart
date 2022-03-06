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
  const OnBoardingScreen({Key? key}) : super(key: key);
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
    OnBoardingItem(
      image: ImageHelper.pageViewFour,
      title: 'CLIENT REVIEWS',
      body: 'Honest feedbacks from our clients. Happy clients - happy us',
    ),
  ];
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final shouldPop = await showMyDialog(context) ;
        return shouldPop;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed:submit,
                child: const Text('SKIP',),
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
                          print('isDone----------------------------');
                          print(isDone);
                        });
                      } else {
                        setState(() {
                          isDone = false;
                          print('isDone----------------------------');
                          print(isDone);

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
                      onDotClicked: onClick,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.blue
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    PhysicalModel(
                      color: Colors.black,
                      elevation: 7.0,
                      shape: BoxShape.circle,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (!isDone) {
                            print('isDone----------------------------');
                            print(isDone);
                            boardController.nextPage(
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.fastLinearToSlowEaseIn);
                          } else {
                            submit();
                          }
                        },
                        child: const Icon(Icons.arrow_forward_outlined),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then(
      (value) {
        bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
        debugPrint('$onBoarding');


        if (value) {
          openNewPage(context, const LoginScreen(), popPreviousPages: true);
        }
      },
    ).catchError(
      (error) {
        debugPrint('error is : ${error.toString()}');
      },
    );
  }
  void onClick(int index){
    boardController.animateToPage(
      index,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 700),
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
