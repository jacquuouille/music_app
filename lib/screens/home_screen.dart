import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8), 
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, 
        appBar: _CustomAppBar(
          ),
        body: Container(),
        ),
      );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget { // we need to put the operator 'with', otherwise there will be an error
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        leading: const Icon(Icons.menu), 
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0), // to separate the CircleAvatar from the right border
            child: CircleAvatar(
              child: Image.asset('assets/image/my_avatar.png'),
            )
          )
        ]
      ),
    );
  }
  
  @override // click sur '_CustomAppBar' to create it
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0); // to define the the bar on top



}