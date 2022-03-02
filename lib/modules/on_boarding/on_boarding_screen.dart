import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:network_app/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });

}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}
var boardController=PageController();

List<BoardingModel> boarding=[
  BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      //image: 'https://assets9.lottiefiles.com/packages/lf20_x4b078j8.json',
      title: 'Faster App Social',
      body: 'Every product you want will be with you faster'
  ),
  BoardingModel(
      image: 'assets/images/onboard_2.jpg',
      //image: 'https://assets9.lottiefiles.com/packages/lf20_cal5i6jf.json',
      title: 'Faster App Social',
      body: 'Every product you want will be with you faster'
  ),
  BoardingModel(
      image: 'assets/images/onboard_3.jpg',
      //image: 'https://assets9.lottiefiles.com/packages/lf20_uge1w2vt.json',
      title: 'Faster App Social',
      body: 'Every product you want will be with you faster'
  ),
];

bool isList = false;




class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,

                onPageChanged:(int index)
                {
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      isList=true;
                    });
                  }else
                  {
                    setState(() {
                      isList=false;
                    });
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            SmoothPageIndicator(
              controller: boardController,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.blueAccent,
                dotColor: Colors.grey,
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5.0,
              ),
              count: boarding.length,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 350 ,
              height: 45.0,
              child: MaterialButton(
                onPressed: () {
                  // navigateAndFinish(context, SocialLoginScreen());
                  if(isList)
                  {
                    CacheHelper.saveData(key: 'onBoarding', value: false).then((value){
                      if(value!)
                      {
                        // navigateAndFinish(context,
                        //   SocialLoginScreen(),
                        // );
                      }
                    });
                  }else
                  {
                    boardController.nextPage(
                      duration: const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                child: const Text (
                  'NEXT',
                  style: TextStyle(
                      color: Colors.white
                  ) ,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(50),
                color: Colors.blueAccent,
              ),
            ),




          ],
        ),
      ),

    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    children: [
      // Lottie.network(model.image),
      Image(
        image: AssetImage(model.image),
      ),
      const SizedBox(
        height: 30.0,
      ),

      Spacer(),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),

      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      )

    ],
  );
}
