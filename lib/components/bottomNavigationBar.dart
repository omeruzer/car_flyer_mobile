import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.placeholder,
  }) : super(key: key);

  final Opacity placeholder;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                tooltip: 'Open navigation menu',
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              placeholder,
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ]),
      ),
    );
  }
}
