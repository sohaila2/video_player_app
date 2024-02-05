import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/drawer_widget.dart';
import '../../widgets/linear_color.dart';

import 'dart:io';

import 'package:path/path.dart';

class HiddenFoldersScreen extends StatefulWidget {
  @override
  _HiddenFoldersScreenState createState() => _HiddenFoldersScreenState();
}

class _HiddenFoldersScreenState extends State<HiddenFoldersScreen> {
  List<String> selectedFolders = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  Future<List<String>> _getHiddenFolders() async {
    try {
      Directory directory = Directory('/storage/emulated/0');
      List<FileSystemEntity> entities = directory.listSync();

      List<String> folders = entities
          .whereType<Directory>()
          .where((entity) => _isHiddenFolder(entity))
          .map((entity) => basename(entity.path))
          .toList();

      return folders;

    } catch (e) {
      print("Error getting hidden folders: $e");
      return [];
    }
  }

  bool _isHiddenFolder(FileSystemEntity entity) {
    if (entity is! Directory) return false;

    // Check if the folder contains files with jpg or mp4 extension
    Directory folder = Directory(entity.path);
    List<FileSystemEntity> files = folder.listSync();
    for (var file in files) {
      if (file is File) {
        String fileExtension = extension(file.path).toLowerCase();
        if (fileExtension == '.jpg' || fileExtension == '.mp4'|| fileExtension == '.mp3') {
          return false; // Not a hidden folder
        }
      }
    }
    return true; // Hidden folder
  }
  @override
  void initState() {
    super.initState();
    _loadSelectedFolders();
  }

  Future<void> _loadSelectedFolders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFolders = prefs.getStringList('selectedFolders');
    if (savedFolders != null) {
      setState(() {
        selectedFolders = savedFolders;
      });
    }
  }

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
      body: Container(
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: ListView.builder(
            itemCount: selectedFolders.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(selectedFolders[index],
                  style: TextStyle(color: Colors.white),),
                subtitle: Text(
                  '/storage/emulated/0 ${selectedFolders[index]}',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
                leading: Image.asset("assets/images/Group 31 (1).png"),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFolderDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddFolderDialog(BuildContext context) async {
    List<String> allFolders = await _getHiddenFolders();
    List<String>? selected = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('/storage/emulated/0',
          style: TextStyle(
            fontSize: 15
          ),),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: 374,
                height: 506,
                child: ListView.builder(
                  itemCount: allFolders.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(allFolders[index]),
                      value: selectedFolders.contains(allFolders[index]),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedFolders.add(allFolders[index]);
                          } else {
                            selectedFolders.remove(allFolders[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setStringList('selectedFolders', selectedFolders);
                Navigator.pop(context, selectedFolders.toList());
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedFolders = selected;
      });
    }
  }
}




