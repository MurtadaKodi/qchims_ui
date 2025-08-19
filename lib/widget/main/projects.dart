// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_02/constant.dart';
import 'package:flutter_application_02/models/project.dart';
import 'package:flutter_application_02/responsive.dart';
import 'package:flutter_application_02/widget/main/project_card.dart';


// ignore: must_be_immutable
class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover Our Sites',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        Responsive(
          Padding(
            padding: const EdgeInsets.all(0),
          ), // Add a dummy Padding widget as the first positional argument
          desktop: buildGridView(
            itemCount: demoProjects.length,
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            itemBuilder: (context, index) {
              final project = demoProjects[index];
              return ProjectCard(
                project: project,
                uri: Uri.parse(project.uri),
              );
            },
          ),
          mobile: buildGridView(
            itemCount: demoProjects.length,
            crossAxisCount: 1,
            childAspectRatio: 0.70,
            itemBuilder: (context, index) {
              final project = demoProjects[index];
              return ProjectCard(
                project: project,
                uri: Uri.parse(project.uri),
              );
            },
          ),
          tablet: buildGridView(
            itemCount: demoProjects.length,
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 3,
            childAspectRatio: 0.75,
            itemBuilder: (context, index) {
              final project = demoProjects[index];
              return ProjectCard(
                project: project,
                uri: Uri.parse(project.uri),
              );
            },
          ),
          mobileLarg: buildGridView(
            itemCount: demoProjects.length,
            crossAxisCount: 1,
            childAspectRatio: 0.75,
            itemBuilder: (context, index) {
              final project = demoProjects[index];
              return ProjectCard(
                project: project,
                uri: Uri.parse(project.uri),
              );
            },
          ),
        ),
        ],
      ),
    );
  }

  GridView buildGridView({required int itemCount,
  required int crossAxisCount,
  required double childAspectRatio,
  required IndexedWidgetBuilder itemBuilder,
  }) {
    return GridView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: Constants.kDefaultPadding,
            mainAxisSpacing: Constants.kDefaultPadding,
          ),
          itemBuilder: itemBuilder,
        );
  }
}

