import 'package:flutter/material.dart';

import '../../widgets/drawer_widget.dart';
import '../../widgets/linear_color.dart';


class CreateNewFolderScreen extends StatelessWidget {
   CreateNewFolderScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 40,
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
              ),
              const Text(
                "Hidden folders",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body:  Container(
        decoration: buildContainerDecoration(),
      ),
    );
  }
}
