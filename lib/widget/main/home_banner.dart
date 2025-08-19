import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';
import 'package:flutter_application_02/responsive.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://res.cloudinary.com/dmklduciw/image/upload/v1746125554/zubara-bg_m14jmh.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            // ignore: deprecated_member_use
            color: Constants.kDarkColor.withOpacity(.10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.kDefaultPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Our App',
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )
                      : Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                ),
                SizedBox(height: 8),
                Text(
                  'Discover amazing content tailored for you.',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
                SizedBox(height: Constants.kDefaultPadding),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/location');
                //   },
                //   child: FittedBox(
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.map,
                //           color: Constants.kBgColor,
                //           size: 22,
                //         ),
                //         Text(' Map >',
                //           style: TextStyle(
                //             color: Constants.kBgColor,
                //             fontSize: Responsive.isDesktop(context) ? 18 : 16,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
