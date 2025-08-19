


import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';
import 'package:flutter_application_02/models/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, required this.uri});

  final Project project;
  final Uri uri;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        color: Constants.kSecondaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(widget.project.image, fit: BoxFit.cover),
                    ),
                    SizedBox(height: Constants.kDefaultPadding),
                    Text(
                      widget.project.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color.fromARGB(255, 235, 239, 244),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: Constants.kDefaultPadding),
                    Text(
                      widget.project.description,
                      maxLines: isShowMore ? 2 : 20,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color.fromARGB(255, 235, 239, 244),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    
                    ),
                    SizedBox(height: Constants.kDefaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            if (!await launchUrl(
                              widget.uri,
                              mode: LaunchMode.externalApplication,
                            )) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Could not open ${widget.uri.toString()}',
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Visit Site',
                            style: TextStyle(color: Constants.kPrimaryColor,
                              ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isShowMore = !isShowMore;
                            });
                          },
                          child: Text(
                            isShowMore ? 'show more ' : 'show less ',
                            style: TextStyle(color: Constants.kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
