import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/linear_color.dart';

class PlayListScreen extends StatefulWidget {
   PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   List<String> playlists = ["Playlist 01"];
 // Initialize with a sample playlist

  @override
  void initState() {
    super.initState();
    // Load playlists from SharedPreferences when the widget is created
    loadPlaylists();
  }
  // Load playlists from SharedPreferences
  Future<void> loadPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      playlists = prefs.getStringList('playlists') ?? [];
    });
  }

  // Save playlists to SharedPreferences
  Future<void> savePlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('playlists', playlists);
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
                  "PlayList",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
                ),
              ],
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: buildContainerDecoration(),
    child: SafeArea(
      child:SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return PlaylistItem(name: playlists[index]);
              },
            ),
          ],
        ),
      ),
      ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 28.0, right: 20.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController playlistController = TextEditingController();
                return AlertDialog(
                  title: const Text('Add Playlist'),
                  content: TextField(
                    controller: playlistController,
                    decoration: const InputDecoration(
                      hintText: 'Enter playlist name',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add the new playlist to the list
                        setState(() {
                          playlists.add(playlistController.text);
                        });
                        savePlaylists();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),    );
  }
}

class PlaylistItem extends StatelessWidget {
  final String name;

  const PlaylistItem({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),
          child: Center(
            child: Image.asset(
              "assets/images/Group 31 (2).png",
              width: 82,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(name),
      ],
    );
  }
}