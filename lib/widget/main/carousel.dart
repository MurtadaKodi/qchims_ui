import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';
import 'package:flutter_application_02/responsive.dart';

class MyCarouselSlider extends StatefulWidget {
  MyCarouselSlider({super.key});

  final List<String> items = [
    "https://res.cloudinary.com/dmklduciw/image/upload/v1716195150/DJI_0262_ieuxeo.jpg",
    "https://res.cloudinary.com/dmklduciw/image/upload/v1715395745/fort-logo_edraop.jpg",
    "https://res.cloudinary.com/dmklduciw/image/upload/v1746214557/AinMohammed/AinMhd_ho9vbh.jpg",
    "https://res.cloudinary.com/dmklduciw/image/upload/v1745998509/Al%20Rekayat/Rekayat_11_bvganc.jpg",
  ];

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.kBgColor,
      child: Responsive.isMobile(context)
          ? Padding(
        padding: const EdgeInsets.only(top: Constants.kDefaultPadding),
        child: CarouselSlider.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(widget.items[itemIndex]),
              ),
          options: CarouselOptions(
            height: 200,
            aspectRatio: .2,
            viewportFraction: .75,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 2),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: true,
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: CarouselSlider.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(widget.items[itemIndex]),
              ),
          options: CarouselOptions(
            height: 300,
            aspectRatio: .2,
            viewportFraction: .4,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 2),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: true,
          ),
        ),
      ),

    );
  }
}
