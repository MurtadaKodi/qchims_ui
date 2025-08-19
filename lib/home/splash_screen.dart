import 'package:flutter/material.dart';

import 'package:flutter_application_02/widget/main/main_section.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3) , () {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (c) => MainSection(title: '',)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network('https://res.cloudinary.com/dmklduciw/image/upload/v1754046830/loading_z0hlm7.gif'),
      ),
    );
  }
}