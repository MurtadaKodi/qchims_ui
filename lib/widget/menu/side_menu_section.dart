import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';
import 'package:flutter_application_02/home/buttom_bar.dart';
import 'package:flutter_application_02/widget/menu/contact_info.dart';
import 'package:flutter_application_02/widget/menu/goals.dart';
import 'package:flutter_application_02/widget/menu/logo.dart';

class SideMenuSection extends StatelessWidget {
  const SideMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Constants.kBgColor,
      child: SafeArea(
        child: Column(
          children: [
            Logo(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Constants.kDefaultPadding),
                child: Column(
                  children: [
                    ContactInfo(),
                    Divider(),
                    Goals(),

                    SizedBox(height: Constants.kDefaultPadding),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/location');
                    //   },
                    //   style: ButtonStyle(
                    //     foregroundColor:
                    //         WidgetStateProperty.resolveWith<Color?>((
                    //           Set<WidgetState> states,
                    //         ) {
                    //           if (states.contains(WidgetState.hovered)) {
                    //             return Colors.red;
                    //           }
                    //           return Colors.green;
                    //         }),
                    //   ),
                    //   child: Container(
                    //     alignment:
                    //         Directionality.of(context) == TextDirection.ltr
                    //         ? Alignment.center
                    //         : Alignment.centerRight,
                    //     padding: EdgeInsets.all(Constants.kDefaultPadding / 4),
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         style: BorderStyle.solid,
                    //         color: Colors.white,
                    //       ),
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     child: FittedBox(
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.location_on,
                    //             color: Constants.kPrimaryColor,
                    //             size: 22,
                    //           ),
                    //           SizedBox(width: Constants.kDefaultPadding),
                    //           Text(
                    //             'Location Map',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     top: Constants.kDefaultPadding * 2,
                    //   ),
                    //   color: Constants.kSecondaryColor,
                    //   child: Row(
                    //     children: [
                    //       Spacer(),
                    //       IconButton(
                    //         onPressed: () {
                    //           Navigator.pushNamed(context, '/location');
                    //         },
                    //         icon: Icon(
                    //           Icons.map,
                    //           color: Colors.white,
                    //           size: 22,
                    //         ),
                    //       ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.search),
                    //       ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.settings),
                    //       ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.person),
                    //       ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.person),
                    //       ),

                    //       Spacer(),

                    //     ],

                    //   ),

                    // ),
                    Padding(padding: const EdgeInsets.only(top: Constants.kDefaultPadding * 5)),
                    ButtomBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
