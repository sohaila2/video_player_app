import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player_app/screens/settings_screen/change_theme_screen.dart';
import 'package:video_player_app/screens/settings_screen/contact_us_screen.dart';
import 'package:video_player_app/screens/settings_screen/hidden_folders_screen.dart';
import 'package:video_player_app/screens/settings_screen/language_screen.dart';
import 'package:video_player_app/screens/settings_screen/remove_ads_screen.dart';
import 'package:video_player_app/screens/settings_screen/share_app_screen.dart';
import 'package:video_player_app/widgets/linear_color.dart';

import '../services/scaffold_key_manager.dart';
import '../widgets/drawer_widget.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
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
                "General",
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
            ListTile(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> RemoveAdsScreen()));

              },
            title: Text("Remove ads",
            style: TextStyle(
              color: Colors.white
            ),),
            ),
              Divider(thickness: 1,color: Colors.white,),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HiddenFoldersScreen()));

                },
                title: Text("Hidden folders",
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
              Divider(thickness: 1,color: Colors.white,),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeThemeScreen()));

                },
                title: Text("Change theme",
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
              Divider(thickness: 1,color: Colors.white,),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LanguageScreen()));

                },
                title: Text("Language",
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
              Divider(thickness: 1,color: Colors.white,),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ShareAppScreen()));
                  Share.share('Quran app\n'
                      'you can develop it from my github github.com/sohaila2');
                },
                title: Text("Share app",
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
              Divider(thickness: 1,color: Colors.white,),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUsScreen()));

                },
                title: Text("Contact us",
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
              Divider(thickness: 1,color: Colors.white,),

            ],
          ),
        ),
      ),
    );
  }
}
