import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildContactInfo(
          context: context,
          title: 'Who',
          info: ' Here is the information about who we are.',
        ),
        buildContactInfo(
          context: context,
          title: 'Where',
          info: 'Various and different locations.',
        ),
        buildContactInfo(
          context: context,
          title: 'Why',
          info: 'Bring history to life.',
        ),
      ],
    );
  }

  Padding buildContactInfo({
    required BuildContext context,
    required String title,
    required String info,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.kDefaultPadding / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: double.infinity,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            info,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Constants.kBodyTextColor),
          ),
        ],
      ),
    );
  }
}
