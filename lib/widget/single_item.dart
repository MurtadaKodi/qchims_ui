// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

class SingleItem extends StatelessWidget {
  late final VoidCallback onTap;
  final String title;
  
  final String image;
   // ignore: prefer_const_constructors_in_immutables
   SingleItem({
    super.key,
    required this.image,
    
    required this.onTap,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 220,
              width: 160,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 0),
                ],
                image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/$image')),
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(height: 6),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
