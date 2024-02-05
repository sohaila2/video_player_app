import 'package:flutter/material.dart';

import '../services/scaffold_key_manager.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: IconButton(
        iconSize: 40,
        color: Colors.white,
        onPressed: () {
          ScaffoldKeyManager.scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
      title: const Text(
        "Video",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
      ),
    );
  }
}