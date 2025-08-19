import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';
import 'package:flutter_application_02/responsive.dart';
import 'package:flutter_application_02/widget/menu/side_menu_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.mainSection,
    required String title, required FloatingActionButton floatingActionButton,
    // required BottomBar bottomBar,
  });
  final Widget mainSection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.pushNamed(context, '/location');
        },
        backgroundColor: Constants.kPrimaryColor,
        child: Icon(Icons.location_on),
      ) ,
      backgroundColor: Constants.kBgColor,
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor: Constants.kBgColor,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              )
            ),
      drawer: SideMenuSection(),
    
    
      // bottomNavigationBar: ButtomBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1440),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                Expanded(flex: 2, child: SideMenuSection()),
                Expanded(flex: 7, child: mainSection),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
