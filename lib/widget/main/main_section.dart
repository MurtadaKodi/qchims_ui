import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';
// import 'package:flutter_application_02/home/buttom_bar.dart';
import 'package:flutter_application_02/screens/home_screen.dart';
import 'package:flutter_application_02/widget/main/carousel.dart';
import 'package:flutter_application_02/widget/main/home_banner.dart';
import 'package:flutter_application_02/widget/main/icon_info.dart';
import 'package:flutter_application_02/widget/main/projects.dart';

class MainSection extends StatelessWidget {
  const MainSection({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HomeScreen(
        mainSection: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CustomScrollView(
            scrollBehavior: ScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // MyAppBar(),
                    HomeBanner(),
                    MyCarouselSlider(),
                    Projects(),
                    IconInfo(),
                    SizedBox(height: Constants.kDefaultPadding),
                    Padding(
                      padding: const EdgeInsets.only(bottom: Constants.kDefaultPadding),
                    ),
                    // ButtomBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.kPrimaryColor,
          child: Icon(Icons.add),

          onPressed: () {
            // Define your action here
          },
        ),
        // Add your desired widget for bottomBar here
        title: '',
    
      ),
    );
  }
}
