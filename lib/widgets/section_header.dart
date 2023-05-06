import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String action; 

  const SectionHeader({
    super.key,
    required this.title, 
    this.action = 'View More'
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
              .textTheme
              .headline6 
              !.copyWith(fontWeight: FontWeight.bold)
          ),
          Text(
            action, 
              style: Theme.of(context)
              .textTheme
              .bodyLarge 
              !.copyWith(fontWeight: FontWeight.bold)
          ) 
        ],),
    );
  }
}