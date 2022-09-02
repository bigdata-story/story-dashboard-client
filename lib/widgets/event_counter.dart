import 'package:flutter/material.dart';

class EventCounter extends StatelessWidget {
  final List<Widget> items;
  final String label;
  final String description;

  const EventCounter({
    Key? key,
    required this.items,
    required this.label,
    this.description = "A description about how we calculate this",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: items.map((e) => e).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class EventWithCountModel {
  final String name;
  final int count;

  EventWithCountModel({required this.name, required this.count});
}
