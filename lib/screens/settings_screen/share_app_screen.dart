

import 'package:flutter/material.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
