import 'package:flutter/material.dart';
import 'package:story_dashboard_client/pages/course_details_page.dart';
import 'package:story_dashboard_client/pages/search_courses_page.dart';

import 'pages/home_page.dart';

class StoryApplication extends StatefulWidget {
  const StoryApplication({Key? key}) : super(key: key);

  @override
  State<StoryApplication> createState() => _StoryApplicationState();
}

class _StoryApplicationState extends State<StoryApplication> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  HomePage(),
    );
  }
}
