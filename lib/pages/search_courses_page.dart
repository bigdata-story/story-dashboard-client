import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:story_dashboard_client/constants.dart';
import 'package:story_dashboard_client/pages/course_details_page.dart';

List<String> _find(String value) {
  final List<String> ans = [];
  for (var course in kCourseIds) {
    if (course.toLowerCase().contains(value.toLowerCase())) {
      ans.add(course);
    }
  }
  return ans;
}

class SearchCoursesPage extends StatefulWidget {
  static const routeName = "/search_courses_page";

  const SearchCoursesPage({Key? key}) : super(key: key);

  @override
  State<SearchCoursesPage> createState() => _SearchCoursesPageState();
}

class _SearchCoursesPageState extends State<SearchCoursesPage> {
  String searchValue = "";
  List<String> searchResults = kCourseIds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: TextField(
              onChanged: (value) {
                compute(_find, value).then((value) {
                  searchResults = value;
                  setState(() {});
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search course',
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: ((context, index) {
                final courseTitle = searchResults[index];
                if (courseTitle.contains(searchValue)) {
                  return ListTile(
                    leading: Text(courseTitle),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CourseDetailsPage(
                            courseName: courseTitle,
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
