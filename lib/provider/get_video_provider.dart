import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class GetVideoProvider extends ChangeNotifier {
  List<FileSystemEntity> _getVideos = [];
  bool _isVideoAvailable = false;

  List<FileSystemEntity> get getVideos => _getVideos;
  bool get isVideoAppAvailable => _isVideoAvailable;

  void getStatus(String ext) async {
    var status = await Permission.manageExternalStorage.request();

    if (status.isDenied) {
      Permission.storage.request();
      log("Permission denied");
      return;
    }

    if (status.isGranted) {
      final directory = Directory("/storage/emulated/0/DCIM/Camera");
    //   Directory? directory = await getExternalStorageDirectory();
         print(directory.path);
      if (directory.existsSync()) {
        final items = directory.listSync();

        if (ext == ".mp4") {
          _getVideos = items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        }

        _isVideoAvailable = true;
        notifyListeners();
        log(items.toString());
      } else {
        log("No Video found");
        _isVideoAvailable = false;
        notifyListeners();
      }
    }
  }

}