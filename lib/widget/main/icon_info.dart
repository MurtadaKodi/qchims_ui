import 'package:flutter/material.dart';

class IconInfo extends StatelessWidget {
  IconInfo({super.key});

  final List<String> imageUrl = [
    'https://res.cloudinary.com/dmklduciw/image/upload/v1745998499/Burj%20Barzan/Barzan_05_fy3k8w.jpg',
    'https://res.cloudinary.com/dmklduciw/image/upload/v1752382659/Lejmail/Lejmail-1_fazfjg.jpg',
    'https://res.cloudinary.com/dmklduciw/image/upload/v1720086096/wall/wall1_tfetcp.jpg',
    'https://res.cloudinary.com/dmklduciw/image/upload/v1745998508/Al%20Thaghab/Thaghab08_tujr6c.jpg',
    'https://res.cloudinary.com/dmklduciw/image/upload/v1746214557/AinMohammed/AinMhd3_ioaooi.jpg',
    'https://res.cloudinary.com/dmklduciw/image/upload/v1745998500/Burj%20Barzan/Barzan_06_ot0o7j.jpg',
  ];
  late final List<String> imageDescription =[
    'Burj Barzan',
    'Lejmail',
    'Alzubara Wall',
    'Al Thaghab',
    'AinMohammed',
    'This is the 6th Site',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrl.length,
        separatorBuilder: (context, index) => SizedBox(width: 18.0),
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    imageUrl[index],
                    fit: BoxFit.cover,
                    height: 220,
                    width: 220,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  ' ${imageDescription[index]}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
