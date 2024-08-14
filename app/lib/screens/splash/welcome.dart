import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:agri2/wrapper.dart';


class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const Wrapper()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/agri3_wel.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      titlePadding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.fromLTRB(16, 60, 16.0, 16.0),
      imageAlignment:Alignment(0, 100)
    );
    const pageDecoration2 = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        titlePadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
        bodyPadding: EdgeInsets.fromLTRB(0.0, 5.0, 16.0, 16.0),
        pageColor: Colors.green,
        imagePadding: EdgeInsets.fromLTRB(16, 60, 16.0, 16.0),
        imageAlignment:Alignment(0, 100)
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,

      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),

      pages: [
        PageViewModel(
          title: "Welcome to Agritech",
          body:
          "Agritech is an innovative platform tailored for the agricultural industry, bridging the gap between farmers and investors on a global scale.",
          image: _buildFullscreenImage(),
          decoration: pageDecoration2.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 150,

          ),
        ),
        PageViewModel(
          title: "Meet Global Famers",
          body:
          "Allows investors and agricultural professionals to meet and engage with farmers from different regions, fostering a diverse network of agricultural talent and opportunities.",
          image: _buildImage('bg_farmer.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Meet Global Investors",
          body:
          "Enables farmers and agricultural businesses to connect with a wide network of investors from around the world. Users can browse investor profiles, view their investment interests, and initiate discussions about potential funding opportunities.",
          image: _buildImage('bg_weaterinv.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "New Technologies",
          body:
          "Providing the latest technological information. This function keeps users informed about cutting-edge advancements, innovations, and trends in agricultural technology.",
          image: _buildImage('agri2_wel.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Latest News in Agriculture Industry",
          body:
          "Esures users stay up-to-date with current events, policy changes, market trends, and other relevant developments in agriculture",
          image: _buildImage('bg_news.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Weather Forecast",
          body:
          "Accurate and up-to-date weather information tailored to their specific agricultural needs.",
          image: _buildImage('bg_weather.png'),
          decoration: pageDecoration,
        ),


      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is the screen after Introduction"),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onBackToIntro(context),
              child: const Text('Back to Introduction'),
            ),
          ],
        ),
      ),
    );
  }
}