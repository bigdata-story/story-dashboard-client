import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:story_dashboard_client/story_application.dart';

import 'utils/api_provider.dart';

final sl = GetIt.instance;
void main() {
  sl.registerLazySingleton(
    () => ApiProvider(
      apiBase: "https://story.samssh.ir",
    ),
  );
  runApp(const StoryApplication());
}
