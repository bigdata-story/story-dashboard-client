import 'dart:convert';
import 'dart:developer';
import 'dart:io';

void main() async {
  String file = await File('course.json').readAsString();
  final Map<String, dynamic> map = json.decode(file);
  log(map.toString());

  List<String> ans = [];

  for (var course in map["courses"]) {
    ans.add(course["course_id"]);
  }

  await File("res.json").writeAsString(json.encode(ans).toString());
}
