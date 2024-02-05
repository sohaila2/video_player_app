import 'package:flutter/material.dart';
import 'package:video_player_app/models/theme_model.dart';
import 'package:video_player_app/widgets/linear_color.dart';

import '../../services/scaffold_key_manager.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/drawer_widget.dart';

class ChangeThemeScreen extends StatelessWidget {
   ChangeThemeScreen({super.key});
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
                "Change Theme",
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
      body: Container(
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: themeImagesList.length,
                itemBuilder: (context, index) {
                  return ThemeImageWidget(themeModel: themeImagesList[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeImageWidget extends StatelessWidget {
   ThemeImageWidget({super.key, required this.themeModel});
   final ThemeModel themeModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
      child: Image.asset(themeModel.image,
        width: 162,
        height: 295,),
    );
  }
}
