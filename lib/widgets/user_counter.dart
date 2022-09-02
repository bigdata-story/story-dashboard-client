import 'package:flutter/material.dart';

class UserCounter extends StatelessWidget {
  final Widget count;
  final String label;
  final String description;
  final Color color;

  const UserCounter({
    Key? key,
    required this.label,
    required this.count,
    this.color = Colors.cyan,
    this.description = "A description about how we calculate this ",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 40,
                    ),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            count,
          ],
        ),
      ),
    );
  }
}
