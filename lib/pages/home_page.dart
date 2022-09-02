import 'package:flutter/material.dart';
import 'package:story_dashboard_client/constants.dart';
import 'package:story_dashboard_client/pages/search_courses_page.dart';
import 'package:story_dashboard_client/widgets/dynamic_state_wrapper.dart';
import 'package:story_dashboard_client/widgets/event_counter.dart';
import 'package:story_dashboard_client/widgets/user_counter.dart';

import '../bloc/request_handler_bloc.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story dashboard"),
      ),
      body: Column(
        children: [
          DynamicStateWrapper(
            endPoint: "/active-users",
            builder: (context, state) {
              if (state is RequestHandlerLoaded) {
                return UserCounter(
                  count: Text(
                    state.ans.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  label: "Active users",
                );
              }
              return const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchCoursesPage(),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Go to courses"),
                    Icon(Icons.arrow_right),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: EventCounter(
              items: List.generate(kEventNames.length, (index) {
                final event = kEventNames[index];
                return DynamicStateWrapper(
                    endPoint: "/event-count",
                    queryParameters: {"event_type": event},
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
