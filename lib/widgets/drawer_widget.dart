import 'package:flutter/material.dart';
import 'package:video_player_app/screens/playlist_screen.dart';
import 'package:video_player_app/screens/settings_screen.dart';

import 'linear_color.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 242,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[700]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 260,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/Rectangle 52 (3).png",
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 0,
                    right: 36,
                    child: Image.asset(
                        "assets/images/SVGRepo_iconCarrier (3).png",
                    ),
                  ),
                  Positioned(
                  bottom: 30,
                    left: 10,
                    right: 0,
                    child: Text(
                      "Video Player",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                    )
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ListTile(
              leading: Icon(Icons.video_call,
                color: Colors.white,),
              title: Text('Video',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_play,
                color: Colors.white,),
              title: Text('Playlist',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayListScreen()));

              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                color: Colors.white,),
              title: Text('Setting',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),),
              onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}