import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_02/home/buttom_bar.dart';
import 'package:flutter_application_02/shared/app_bar.dart';


class AlZubara extends StatelessWidget {
  AlZubara({super.key, required String title});

  final List<String> items = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
    "assets/image4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ButtomBar(),
        appBar: MyAppBar(),
        body: Column(
          children: [
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(item, fit: BoxFit.cover),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
