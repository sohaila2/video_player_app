import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer';
import 'dart:io';

import '../widgets/linear_color.dart';



class DisplayVideoScreen extends StatefulWidget {
  const DisplayVideoScreen({super.key, required this.videopath});
  final String? videopath;
  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {

  ChewieController? _chewieController;



  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
        videoPlayerController:
        VideoPlayerController.file(
          File(widget.videopath!),
        ),
        autoInitialize: true,
        errorBuilder: ((context,errorMessage){
          return Center(
            child: Text(errorMessage),
          );
        })
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back_ios,
                            color: Colors.white,),),

                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Center(
                          child: Container(
                            height: 340,
                            width: 320,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(File(widget.videopath!)),
                                  fit: BoxFit.fill
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              child: Chewie(
                                controller: _chewieController!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
