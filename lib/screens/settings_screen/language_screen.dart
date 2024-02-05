import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

import '../../widgets/drawer_widget.dart';
import '../../widgets/linear_color.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> languages = ["English","Chinese","Hindi","Urdu", "Polish", "Dutch", "Italian"]; // Add your languages here
  List<bool> isSelected = List.generate(7, (index) => false); // Initial state for icons
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
                "Language",
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
          child: Center(
            child: Container(
              width: 292,
              height: 506,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 8.0),
                    child: Text(
                      "Select language",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(languages[index]),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSelected[index] = !isSelected[index];
                                  });
                                },
                                icon: Icon(
                                  isSelected[index]
                                      ? Icons.circle
                                      : Icons.circle_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
