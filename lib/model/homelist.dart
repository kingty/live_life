import 'package:live_life/keep_accounts/ui/keep_accounts_home_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [

    HomeList(
      imagePath: 'assets/keep_accounts/fitness_app.png',
      navigateScreen: KeepAccountsHomeScreen(),
    ),
    // HomeList(
    //   imagePath: 'assets/introduction_animation/introduction_animation.png',
    //   navigateScreen: IntroductionAnimationScreen(),
    // ),
    // HomeList(
    //   imagePath: 'assets/hotel/hotel_booking.png',
    //   navigateScreen: HotelHomeScreen(),
    // ),
    // HomeList(
    //   imagePath: 'assets/design_course/design_course.png',
    //   navigateScreen: DesignCourseHomeScreen(),
    // ),
  ];
}
