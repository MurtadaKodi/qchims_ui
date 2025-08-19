

import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        color: Constants.kSecondaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(flex: 2,),
            Image.network(
              'https://res.cloudinary.com/dmklduciw/image/upload/v1755496893/fort_Profile_xiov9t.png',
              // fit: BoxFit.cover,
              width: 150,
            ),
            Spacer(),
            Text(
              '',
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
            Text(
              'Historical \n Sites',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 22),
            ),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}