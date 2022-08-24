import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.green,
      child: Center(
        child: Text(
          text.toUpperCase(),
        ),
      ),
    );
  }
}
