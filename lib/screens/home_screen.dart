import 'dart:io';
import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/screens/video_screen.dart';
import '../provider/get_video_provider.dart';
import '../services/scaffold_key_manager.dart';
import '../utils/get_thumbnail.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/linear_color.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {

  bool showVideos = true;
  List<String> folderNames = [];

  @override
  void initState() {
    super.initState();
    _getFolders();
  }

  Future<void> _getFolders() async {
    try {
      Directory directory = Directory('/storage/emulated/0/DCIM');
      List<FileSystemEntity> entities = directory.listSync();

      List<String> folders = entities
          .whereType<Directory>()
          .map((entity) => basename(entity.path))
          .toList();

      setState(() {
        folderNames = folders;
      });
    } catch (e) {
      print("Error getting folders: $e");
    }
  }

  Future<int> _countVideosInFolder(String folderName) async {
    try {
      Directory folder = Directory('/storage/emulated/0/DCIM/$folderName');
      List<FileSystemEntity> entities = folder.listSync();

      int videoCount = entities
          .whereType<File>()
          .where((entity) => entity.path.toLowerCase().endsWith('.mp4'))
          .length;

      return videoCount;
    } catch (e) {
      print("Error counting videos in $folderName: $e");
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      extendBodyBehindAppBar: true,
      key: ScaffoldKeyManager.scaffoldKey,
      drawer: const DrawerWidget(),
      body: Container(
        height: double.infinity,
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      primary: showVideos ? Colors.white : Colors.transparent,
                      shape: showVideos ?  RoundedRectangleBorder(
          side: BorderSide(
          color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ) : null
                    ),
                    onPressed: () {
                      setState(() {
                        showVideos = true;
                      });
                    },
                    child: Text('All Videos'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        primary: showVideos ? Colors.transparent : Colors.white,
                        shape: showVideos ? null : RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                    onPressed: () {
                      setState(() {
                        showVideos = false;
                      });
                    },
                    child: Text('Folders'),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child:
                     showVideos ?
                     FutureBuilder(
                       future: ListAllVideos().getAllVideosPath(),
                       builder: (context, snapshot) {
                         return snapshot.connectionState == ConnectionState.waiting
                             ? const Center(
                           child: CircularProgressIndicator(),
                         )
                             : ListView.builder(
                           itemBuilder: (context, index) {
                             VideoDetails currentVideo = snapshot.data![index];
                             return ListTile(
                               onTap: (){
                                 Navigator.push(context, CupertinoPageRoute(builder: (_)=>
                                     DisplayVideoScreen(
                                       videopath: currentVideo.videoPath,
                                     )));
                               },
                               title: Text(
                                 currentVideo.videoName,
                                 style: TextStyle(color: Colors.white),
                               ),
                               subtitle: Text(currentVideo.videoSize,
                                 style: TextStyle(color: Colors.white),),
                               leading: ThumbnailTile(
                                 thumbnailController: currentVideo.thumbnailController,
                                 height: 800,
                                 width: 108,
                               ),
                               trailing: PopupMenuButton<String>(
                                 color: Colors.black,
                                 iconColor: Colors.white,
                                 onSelected: (value) {},
                                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                   const PopupMenuItem<String>(
                                     value: 'play',
                                     child: Text('Play',
                                     style: TextStyle(
                                       color: Colors.white
                                     ),),
                                   ),
                                   const PopupMenuItem<String>(
                                     value: 'addToNextPlay',
                                     child: Text('Add to Next Play',
                                       style: TextStyle(
                                           color: Colors.white
                                       ),
                                     ),
                                   ),
                                   const PopupMenuItem<String>(
                                     value: 'addToQueue',
                                     child: Text('Add to Queue',
                                       style: TextStyle(
                                           color: Colors.white
                                       ),),
                                   ),
                                   const PopupMenuItem<String>(
                                     value: 'addToPlaylist',
                                     child: Text('Add to Playlist',
                                       style: TextStyle(
                                           color: Colors.white
                                       ),),
                                   ),
                                   const PopupMenuItem<String>(
                                     value: 'addToFavorites',
                                     child: Text('Add to Favorites',
                                       style: TextStyle(
                                           color: Colors.white
                                       ),),
                                   ),
                                   const PopupMenuItem<String>(
                                     value: 'share',
                                     child: Text('Share',
                                       style: TextStyle(
                                           color: Colors.white
                                       ),),
                                   ),
                                   const PopupMenuItem<String>(
                                     value: 'delete',
                                     child: Text('Delete',
                                       style: TextStyle(
                                           color: Colors.white
                                       ),),
                                   ),
                                 ],
                               ),
                             );
                           },
                           itemCount: snapshot.data!.length,
                         );
                       },
                     )
                         :
                     Padding(
                       padding: const EdgeInsets.only(top: 8.0),
                       child: ListView.builder(
                         itemCount: folderNames.length,
                         itemBuilder: (context, index) {
                           return FutureBuilder(
                             future: _countVideosInFolder(folderNames[index]),
                             builder: (context, snapshot) {
                               int videoCount = snapshot.data ?? 0;

                               return Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 12.0),
                                 child: ListTile(
                                   title: Text(
                                     folderNames[index],
                                     style: TextStyle(color: Colors.white),
                                   ),
                                   subtitle: Text(
                                     '$videoCount videos',
                                     style: TextStyle(color: Colors.white),
                                   ),
                                   onTap: () {},
                                   leading: Image.asset("assets/images/Group 31 (1).png"),
                                 ),
                               );
                             },
                           );
                         },
                       ),
                     )
                ),
              ),
            ],
          ),

        ),
      )
    );
  }
}












