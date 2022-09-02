import 'package:flutter/material.dart';
import 'package:story_dashboard_client/bloc/request_handler_bloc.dart';
import 'package:story_dashboard_client/constants.dart';

import '../widgets/dynamic_state_wrapper.dart';
import '../widgets/event_counter.dart';
import '../widgets/user_counter.dart';

class CourseDetailsPage extends StatefulWidget {
  static const routeName = "/course_details";
  final String courseName;

  const CourseDetailsPage({
    Key? key,
    required this.courseName,
  }) : super(key: key);

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: Column(
        children: [
          UserCounter(
            count: DynamicStateWrapper(
                endPoint: "/active-users-in-course",
                queryParameters: {
                  "course_id": widget.courseName,
                },
                builder: (context, state) {
                  if (state is RequestHandlerLoaded) {
                    return Text(
                      state.ans.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    );
                  }
                  return const CircularProgressIndicator();
                }),
            label: "Active users",
            color: Colors.amber,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.play_circle,
                      color: Colors.amber,
                      size: 40,
                    ),
                    Text(
                      "Played course time",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                DynamicStateWrapper(
                    endPoint: "/course-played-time",
                    queryParameters: {
                      "course_id": widget.courseName,
                    },
                    builder: (context, state) {
                      if (state is RequestHandlerLoaded) {
                        return Text(
                          state.ans,
                          style: Theme.of(context).textTheme.headline5,
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: EventCounter(
              items: List.generate(kEventNames.length, (index) {
                final event = kEventNames[index];
                return DynamicStateWrapper(
                    endPoint: "/event-count-in-course",
                    queryParameters: {
                      "course_id": widget.courseName,
                      "event_type": kEventNames[index],
                    },
                    builder: (context, state) {
                      if (state is RequestHandlerLoaded) {
                        return ListTile(
                          leading: Text(event),
                          trailing: Text(
                            state.ans,
                          ),
                        );
                      }
                      return ListTile(
                        leading: Text(event),
                        trailing: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    });
              }),
              label: "Event counts in last one hour",
            ),
          ),
        ],
      ),
    );
  }
}
